%%****************************************************************
%%* wise.cls — DEPRECATED compatibility shim                     *
%%****************************************************************
%%
%% The class was renamed to 'fgdh-thesis'. This shim keeps existing documents
%% that use \documentclass{wise} compiling: it forwards all options to and loads
%% the fgdh-thesis class, and emits a one-time deprecation warning.
%%
%% New documents should use \documentclass{fgdh-thesis}. This alias may be
%% removed in a future major release.
%%
%% Same license/maintenance status as fgdh-thesis.cls (LPPL 1.3c or later).

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wise}[2026/06/22 v2.0.0 Deprecated alias for the fgdh-thesis class]

\ClassWarningNoLine{wise}{%
  The 'wise' class has been renamed to 'fgdh-thesis'.\MessageBreak
  'wise' is now a deprecated alias and may be removed in a future release.\MessageBreak
  Please replace \string\documentclass{wise} with\MessageBreak
  \string\documentclass{fgdh-thesis}%
}

% Forward the given class options and load the real class.
\LoadClassWithOptions{fgdh-thesis}
