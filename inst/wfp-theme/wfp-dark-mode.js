// ============================================================================
// WFP Dark Mode Toggle - JavaScript
// ============================================================================
// Handles dark mode toggling for the WFP Bootswatch theme.
// Supports manual toggle, system preference detection, and server-side control.
//
// Usage:
//   This script is automatically included when wfp_theme(dark_mode = TRUE)
//   or wfp_theme(dark_mode = "auto") is used.
// ============================================================================

(function() {
  "use strict";

  // Key for localStorage persistence
  const STORAGE_KEY = "wfp-dark-mode";

  // Get the root HTML element
  const htmlEl = document.documentElement;

  // Check if Bootstrap 5 theming is available
  function getBsTheme() {
    return htmlEl.getAttribute("data-bs-theme") || "light";
  }

  function setBsTheme(theme) {
    htmlEl.setAttribute("data-bs-theme", theme);
    // Also set a class for backward compatibility
    if (theme === "dark") {
      htmlEl.classList.add("wfp-dark");
      htmlEl.classList.remove("wfp-light");
    } else {
      htmlEl.classList.add("wfp-light");
      htmlEl.classList.remove("wfp-dark");
    }
    // Persist user preference
    try {
      localStorage.setItem(STORAGE_KEY, theme);
    } catch (e) {
      // localStorage may be unavailable (private mode, etc.)
    }
    // Dispatch a custom event for other components to react
    window.dispatchEvent(new CustomEvent("wfp-dark-mode-changed", {
      detail: { theme: theme }
    }));
  }

  // Toggle between light and dark
  function toggleDarkMode() {
    var current = getBsTheme();
    var next = current === "dark" ? "light" : "dark";
    setBsTheme(next);
    return next;
  }

  // Set a specific mode
  function setDarkMode(mode) {
    if (mode === "toggle") {
      return toggleDarkMode();
    } else if (mode === "dark" || mode === true) {
      setBsTheme("dark");
      return "dark";
    } else if (mode === "light" || mode === false) {
      setBsTheme("light");
      return "light";
    }
  }

  // Initialize: check localStorage first, then system preference
  function initializeDarkMode() {
    var stored = null;
    try {
      stored = localStorage.getItem(STORAGE_KEY);
    } catch (e) {
      // localStorage unavailable
    }

    if (stored === "dark" || stored === "light") {
      setBsTheme(stored);
    } else {
      // If auto mode, check system preference
      var systemDark = window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches;
      var currentAttr = htmlEl.getAttribute("data-bs-theme");

      if (currentAttr === "auto" || !currentAttr) {
        setBsTheme(systemDark ? "dark" : "light");

        // Listen for system preference changes
        if (window.matchMedia) {
          window.matchMedia("(prefers-color-scheme: dark)").addEventListener("change", function(e) {
            // Only auto-switch if no user preference is stored
            var userPref = null;
            try {
              userPref = localStorage.getItem(STORAGE_KEY);
            } catch (e2) {}

            if (!userPref) {
              setBsTheme(e.matches ? "dark" : "light");
            }
          });
        }
      }
    }
  }

  // Set up toggle buttons
  function setupToggleButtons() {
    var buttons = document.querySelectorAll('[data-wfp-toggle="dark-mode"]');

    buttons.forEach(function(btn) {
      btn.addEventListener("click", function(e) {
        e.preventDefault();
        var newTheme = toggleDarkMode();

        // If shiny is available, send the value to the server
        if (window.Shiny && window.Shiny.setInputValue) {
          window.Shiny.setInputValue(btn.id || "wfp_dark_mode", newTheme === "dark");
        }

        // Update button appearance
        updateToggleButton(btn, newTheme);
      });

      // Set initial button state
      updateToggleButton(btn, getBsTheme());
    });
  }

  // Update toggle button appearance based on current theme
  function updateToggleButton(btn, theme) {
    if (!btn) return;

    var iconSpan = btn.querySelector(".wfp-theme-icon");
    var isDark = theme === "dark";

    // Update icon
    if (iconSpan) {
      iconSpan.innerHTML = isDark ? "&#9788;&#65038;" : "&#9789;";
    } else if (btn.childNodes.length > 0 && btn.childNodes[0].nodeType === 3) {
      // Text node - update the text content
      btn.childNodes[0].textContent = isDark ? "\u2600\uFE0E " : "\u263D ";
    }

    // Update ARIA label
    btn.setAttribute("aria-label", isDark ? "Switch to light mode" : "Switch to dark mode");

    // Toggle active class
    if (isDark) {
      btn.classList.add("active");
    } else {
      btn.classList.remove("active");
    }
  }

  // Listen for Shiny server messages
  if (window.Shiny) {
    window.Shiny.addCustomMessageHandler("wfp-set-dark-mode", function(msg) {
      if (msg && msg.mode) {
        setDarkMode(msg.mode);
      }
    });
  }

  // Initialize when DOM is ready
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", function() {
      initializeDarkMode();
      setupToggleButtons();
    });
  } else {
    initializeDarkMode();
    setupToggleButtons();
  }

  // Also set up a MutationObserver to catch dynamically added toggle buttons
  var observer = new MutationObserver(function(mutations) {
    var shouldSetup = false;
    mutations.forEach(function(mutation) {
      mutation.addedNodes.forEach(function(node) {
        if (node.nodeType === 1) { // Element node
          if (node.matches && node.matches('[data-wfp-toggle="dark-mode"]')) {
            shouldSetup = true;
          }
          if (node.querySelector && node.querySelector('[data-wfp-toggle="dark-mode"]')) {
            shouldSetup = true;
          }
        }
      });
    });
    if (shouldSetup) {
      setupToggleButtons();
    }
  });

  if (document.body) {
    observer.observe(document.body, { childList: true, subtree: true });
  } else {
    document.addEventListener("DOMContentLoaded", function() {
      observer.observe(document.body, { childList: true, subtree: true });
    });
  }

  // Expose API globally for debugging and manual control
  window.wfpDarkMode = {
    toggle: toggleDarkMode,
    set: setDarkMode,
    get: getBsTheme,
    isDark: function() { return getBsTheme() === "dark"; }
  };

})();
