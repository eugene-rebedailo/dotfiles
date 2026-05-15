return {
  {
    'seblyng/roslyn.nvim',
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    ft = { 'cs', 'csproj' },
    opts = {
      filewatching = 'roslyn',
      config = {
        settings = {
          ['csharp|background_analysis'] = {
            dotnet_analyzer_diagnostics_scope = 'openFiles',
            dotnet_compiler_diagnostics_scope = 'fullSolution',
          },
          ['csharp|completion'] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
          },
        },
      },
    },
  },
  {
    'ziemcd/roslyn-workspace-diagnostics.nvim',
    -- Disable for now until fix for nvim 0.12 comes out
    enabled = false,
    opts = {
      csproj_watcher = {
        enabled = true,
      },
    },
  },
}
