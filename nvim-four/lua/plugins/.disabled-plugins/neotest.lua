---@type LazySpec[]
local dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
}

---@type LazySpec
local spec = {
    "nvim-neotest/neotest",
    --lazy = false,
    --ft = "",
    --cmd = "CMDNAME",
    --keys = "",
    --event = "VeryLazy",
    dependencies = dependencies,
    --init = function()
    --    INIT
    --end,
    --opts = {
    --    OPTS
    --},
    --config = function()
    --    INIT
    --end,
    cond = false,
    enabled = false,
}

return spec

--[[

*neotest.txt*	A framework to interact with tests within NeoVim

==============================================================================
neotest                                                                *neotest*

  Setup......................................................|neotest.setup()|
  Configuration Options.......................................|neotest.config|
  Consumers................................................|neotest.consumers|
  Output Consumer.............................................|neotest.output|
  Output Panel Consumer.................................|neotest.output_panel|
  Run Consumer...................................................|neotest.run|
  Watch Consumer...............................................|neotest.watch|
  Status Consumer.............................................|neotest.status|
  Diagnostic Consumer.....................................|neotest.diagnostic|
  Summary Consumer...........................................|neotest.summary|
  Jump Consumer.................................................|neotest.jump|
  Quickfix Consumer.........................................|neotest.quickfix|
  State Consumer...............................................|neotest.state|
  Neotest Client..............................................|neotest.Client|
  Library........................................................|neotest.lib|
  Library: Files...........................................|neotest.lib.files|
  Library: Function Utilities..........................|neotest.lib.func_util|
  Library: Positions...................................|neotest.lib.positions|
  Library: Treesitter.................................|neotest.lib.treesitter|
  Library: Processes.....................................|neotest.lib.process|
  Library: XML...............................................|neotest.lib.xml|


There are three main components to this plugin's architecture.
 - Adapters: Generally language specific objects to parse tests, build commands
 and parse results

 - Client: Runs tests and stores state of tests and results, emitting events
 during operation

 - Consumers: Use the client to provide some utility to interact with tests and
 results

In order to use neotest, you must use an adapter for your language of choice.
You can supply them in the setup function.

Once you have setup an adapter, you can use neotest consumers to run and
interact with tests.
For most users, the bulk of relevant features will be in the consumers.

Each consumer can be accessed as a property of the neotest module
See the table of contents for the consumers

>vim
   lua require("neotest").summary.toggle()
<


                                                               *neotest.setup()*
`setup`({user_config})


Neotest strategies and consumers
See also ~
|neotest.Config|

Parameters~
{user_config} `(neotest.Config)`

Default values:
>lua
  {
    adapters = {},
    benchmark = {
      enabled = true
    },
    consumers = {},
    default_strategy = "integrated",
    diagnostic = {
      enabled = true,
      severity = 1
    },
    discovery = {
      concurrent = 0,
      enabled = true
    },
    floating = {
      border = "rounded",
      max_height = 0.6,
      max_width = 0.6,
      options = {}
    },
    highlights = {
      adapter_name = "NeotestAdapterName",
      border = "NeotestBorder",
      dir = "NeotestDir",
      expand_marker = "NeotestExpandMarker",
      failed = "NeotestFailed",
      file = "NeotestFile",
      focused = "NeotestFocused",
      indent = "NeotestIndent",
      marked = "NeotestMarked",
      namespace = "NeotestNamespace",
      passed = "NeotestPassed",
      running = "NeotestRunning",
      select_win = "NeotestWinSelect",
      skipped = "NeotestSkipped",
      target = "NeotestTarget",
      test = "NeotestTest",
      unknown = "NeotestUnknown",
      watching = "NeotestWatching"
    },
    icons = {
      child_indent = "│",
      child_prefix = "├",
      collapsed = "─",
      expanded = "╮",
      failed = "",
      final_child_indent = " ",
      final_child_prefix = "╰",
      non_collapsible = "─",
      notify = "",
      passed = "",
      running = "",
      running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
      skipped = "",
      unknown = "",
      watching = ""
    },
    jump = {
      enabled = true
    },
    log_level = 3,
    output = {
      enabled = true,
      open_on_run = "short"
    },
    output_panel = {
      enabled = true,
      open = "botright split | resize 15"
    },
    projects = {},
    quickfix = {
      enabled = true,
      open = false
    },
    run = {
      enabled = true
    },
    running = {
      concurrent = true
    },
    state = {
      enabled = true
    },
    status = {
      enabled = true,
      signs = true,
      virtual_text = false
    },
    strategies = {
      integrated = {
        height = 40,
        width = 120
      }
    },
    summary = {
      animated = true,
      count = true,
      enabled = true,
      expand_errors = true,
      follow = true,
      mappings = {
        attach = "a",
        clear_marked = "M",
        clear_target = "T",
        debug = "d",
        debug_marked = "D",
        expand = { "<CR>", "<2-LeftMouse>" },
        expand_all = "e",
        help = "?",
        jumpto = "i",
        mark = "m",
        next_failed = "J",
        output = "o",
        prev_failed = "K",
        run = "r",
        run_marked = "R",
        short = "O",
        stop = "u",
        target = "t",
        watch = "w"
      },
      open = "botright vsplit | vertical resize 50"
    },
    watch = {
      enabled = true,
      symbol_queries = {
        elixir = <function 1>,
        go = "        ;query\n        ;Captures imported types\n        (qualified_type name: (type_identifier) @symbol)\n        ;Captures package-local and built-in types\n        (type_identifier)@symbol\n        ;Captures imported function calls and variables/constants\n        (selector_expression field: (field_identifier) @symbol)\n        ;Captures package-local functions calls\n        (call_expression function: (identifier) @symbol)\n      ",
        haskell = "        ;query\n        ;explicit import\n        ((import_item [(variable)]) @symbol)\n        ;symbols that may be imported implicitly\n        ((type) @symbol)\n        (qualified_variable (variable) @symbol)\n        (exp_apply (exp_name (variable) @symbol))\n        ((constructor) @symbol)\n        ((operator) @symbol)\n      ",
        java = "        ;query\n        ;captures imported classes\n        (import_declaration\n            (scoped_identifier name: ((identifier) @symbol))\n        )\n      ",
        javascript = '  ;query\n  ;Captures named imports\n  (import_specifier name: (identifier) @symbol)\n  ;Captures default import\n  (import_clause (identifier) @symbol)\n  ;Capture require statements\n  (variable_declarator \n  name: (identifier) @symbol\n  value: (call_expression (identifier) @function  (#eq? @function "require")))\n  ;Capture namespace imports\n  (namespace_import (identifier) @symbol)\n',
        lua = '        ;query\n        ;Captures module names in require calls\n        (function_call\n          name: ((identifier) @function (#eq? @function "require"))\n          arguments: (arguments (string) @symbol))\n      ',
        python = "        ;query\n        ;Captures imports and modules they're imported from\n        (import_from_statement (_ (identifier) @symbol))\n        (import_statement (_ (identifier) @symbol))\n      ",
        ruby = '        ;query\n        ;rspec - class name\n        (call\n          method: (identifier) @_ (#match? @_ "^(describe|context)")\n          arguments: (argument_list (constant) @symbol )\n        )\n\n        ;rspec - namespaced class name\n        (call\n          method: (identifier)\n          arguments: (argument_list\n            (scope_resolution\n              name: (constant) @symbol))\n        )\n      ',
        rust = "        ;query\n        ;submodule import\n        (mod_item\n          name: (identifier) @symbol)\n        ;single import\n        (use_declaration\n          argument: (scoped_identifier\n            name: (identifier) @symbol))\n        ;import list\n        (use_declaration\n          argument: (scoped_use_list\n            list: (use_list\n                [(scoped_identifier\n                   path: (identifier)\n                   name: (identifier) @symbol)\n                 ((identifier) @symbol)])))\n        ;wildcard import\n        (use_declaration\n          argument: (scoped_use_list\n            path: (identifier)\n            [(use_list\n              [(scoped_identifier\n                path: (identifier)\n                name: (identifier) @symbol)\n                ((identifier) @symbol)\n              ])]))\n      ",
        tsx = '  ;query\n  ;Captures named imports\n  (import_specifier name: (identifier) @symbol)\n  ;Captures default import\n  (import_clause (identifier) @symbol)\n  ;Capture require statements\n  (variable_declarator \n  name: (identifier) @symbol\n  value: (call_expression (identifier) @function  (#eq? @function "require")))\n  ;Capture namespace imports\n  (namespace_import (identifier) @symbol)\n',
        typescript = '  ;query\n  ;Captures named imports\n  (import_specifier name: (identifier) @symbol)\n  ;Captures default import\n  (import_clause (identifier) @symbol)\n  ;Capture require statements\n  (variable_declarator \n  name: (identifier) @symbol\n  value: (call_expression (identifier) @function  (#eq? @function "require")))\n  ;Capture namespace imports\n  (namespace_import (identifier) @symbol)\n'
      }
    }
  }
<

                                                       *neotest.setup_project()*
`setup_project`({project_root}, {project_config})

Configure a project individually.
Parameters~
{project_root} `(string)`
{project_config} `(neotest.CoreConfig)`


==============================================================================
neotest.config                                                  *neotest.config*

                                                            *neotest.CoreConfig*
Fields~
{adapters} `(neotest.Adapter[])`
{discovery} `(neotest.Config.discovery)`
{running} `(neotest.Config.running)`
{default_strategy} `(string|function)`

                                                                *neotest.Config*
Inherits: `neotest.CoreConfig`

Fields~
{log_level} `(number)` Minimum log levels, one of vim.log.levels
{consumers} `(table<string, neotest.Consumer>)`
{icons} `(table)` Icons used throughout the UI. Defaults use VSCode's codicons
{highlights} `(table<string, string>)`
{floating} `(neotest.Config.floating)`
{strategies} `(neotest.Config.strategies)`
{run} `(neotest.Config.run)`
{summary} `(neotest.Config.summary)`
{output} `(neotest.Config.output)`
{output_panel} `(neotest.Config.output_panel)`
{quickfix} `(neotest.Config.quickfix)`
{status} `(neotest.Config.status)`
{state} `(neotest.Config.state)`
{watch} `(neotest.Config.watch)`
{diagnostic} `(neotest.Config.diagnostic)`
{projects} `(table<string, neotest.CoreConfig>)` Project specific settings,
keys
are project root directories (e.g "~/Dev/my_project")

                                                      *neotest.Config.discovery*
Fields~
{enabled} `(boolean)`
{concurrent} `(integer)` Number of workers to parse files concurrently. 0
automatically assigns number based on CPU. Set to 1 if experiencing lag.
{filter_dir} `(nil)` | fun(name: string, rel_path: string, root: string):
boolean A function to filter directories when searching for test files.
Receives the name, path relative to project root and project root path

                                                        *neotest.Config.running*
Fields~
{concurrent} `(boolean)` Run tests concurrently when an adapter provides
multiple commands to run

                                                              *neotest.Consumer*
Alias~
`neotest.Consumer` → `fun(client: neotest.Client): table`

                                                       *neotest.Config.floating*
Fields~
{border} `(string)` Border style
{max_height} `(number)` Max height of window as proportion of NeoVim window
{max_width} `(number)` Max width of window as proportion of NeoVim window
{options} `(table)` Window local options to set on floating windows (e.g.
winblend)

                                          *neotest.Config.strategies.integrated*
Fields~
{width} `(integer)` Width to pass to the pty runnning commands

                                                     *neotest.Config.strategies*
Fields~
{integrated} `(neotest.Config.strategies.integrated)`

                                                            *neotest.Config.run*
Fields~
{enabled} `(boolean)`
{augment?} `(fun(tree: neotest.Tree, arg:
neotest.run.RunArgs):neotest.run.RunArgs)` A function to augment the arguments
any tests being run

                                                        *neotest.Config.summary*
Fields~
{enabled} `(boolean)`
{animated} `(boolean)` Enable/disable animation of icons
{follow} `(boolean)` Expand user's current file
{expand_errors} `(boolean)` Expand all failed positions
{mappings} `(neotest.Config.summary.mappings)` Buffer mappings for summary
window
{open} `(string)` | fun(): integer A command or function to open a window for
the summary
{count} `(boolean)` Display number of tests found beside the adapter name

                                               *neotest.Config.summary.mappings*
Fields~
{expand} `(string|string[])` Expand currently selected position
{expand_all} `(string|string[])` Expand all positions under currently selected
{output} `(string|string[])` Show output for position
{short} `(string|string[])` Show short output for position (if exists)
{attach} `(string|string[])` Attach to process for position
{jumpto} `(string|string[])` Jump to the selected position
{stop} `(string|string[])` Stop selected position
{run} `(string|string[])` Run selected position
{debug} `(string|string[])` Debug selected position
{mark} `(string|string[])` Mark the selected position
{run_marked} `(string|string[])` Run the marked positions for selected suite.
{debug_marked} `(string|string[])` Debug the marked positions for selected
suite.
{clear_marked} `(string|string[])` Clear the marked positions for selected
suite.
{target} `(string|string[])` Target a position to be the only shown position
for its adapter
{clear_target} `(string|string[])` Clear the target position for the selected
adapter
{next_failed} `(string|string[])` Jump to the next failed position
{prev_failed} `(string|string[])` Jump to the previous failed position
{watch} `(string|string[])` Toggle watching for changes

                                                         *neotest.Config.output*
Fields~
{enabled} `(boolean)`
{open_on_run} `(string|boolean)` Open nearest test result after running

                                                          *neotest.Config.state*
Fields~
{enabled} `(boolean)`

                                                   *neotest.Config.output_panel*
Fields~
{enabled} `(boolean)`
{open} `(string|fun():integer)` A command or function to open a window for the
output panel

                                                       *neotest.Config.quickfix*
Fields~
{enabled} `(boolean)`
{open} `(boolean|function)` Set to true to open quickfix on startup, or a
function to be
called when the quickfix results are set

                                                     *neotest.Config.diagnostic*
Fields~
{enabled} `(boolean)`
{severity} `(number)` Diagnostic severity, one of vim.diagnostic.severity

                                                         *neotest.Config.status*
Fields~
{enabled} `(boolean)`
{virtual_text} `(boolean)` Display status using virtual text
{signs} `(boolean)` Display status using signs

                                                          *neotest.Config.watch*
Fields~
{enabled} `(boolean)`
{symbol_queries} `(table<string, string|fun(root, content: string, path:
string):integer[][]>)` Treesitter queries or functions to capture symbols that
are used for querying the LSP server for defintions to link files. If it is a
function then the return value should be a list of node ranges.
{filter_path?} `(fun(path: string, root: string): boolean)` Returns whether
the watcher should inspect a path for dependencies. Default ignores paths not
under root or common package manager directories.


==============================================================================
neotest.consumers                                            *neotest.consumers*


Consumers provide user consumable APIs by wrapping the lower level client
object. If you are developing a consumer, it is strongly recommended to enable
type checking of the `neotest` repo, as it will provide very helpful type
hints/docs. You can use https://github.com/folke/lua-dev.nvim to do this easily.

A consumer is a function which takes a neotest.Client object. The function can
optionally return a table containing functions which will be directly accessable
on the `neotest` module under the consumers name. For example, the `run`
consumer returns a table with `run`, `attach` and `stop` and so users can call
`neotest.run.run`, `neotest.run.attach` and `neotest.run.stop`

The client interface provides methods for interacting with tests, fetching
results as well as event listeners. To listen to an event, just assign the event
listener to a function:
>lua
  client.listeners.discover_positions = function (adapter_id, tree)
    ...
  end
<
Available events and the listener signatures are visible as properties on the
`client.listeners` table

The majority of interactions with the client will involved the use of the
positions tree. Each adapter instance has a separate tree, so you should track
which adapter ID you are using throughout several calls.


==============================================================================
neotest.output                                                  *neotest.output*


A consumer that displays the output of test results.

                                             *neotest.consumers.output.OpenArgs*
Fields~
{open_win} `(function?)` Function that takes a table with width and height
keys
and opens a window for the output. If a window ID is not returned, the current
window will be used
{short} `(boolean?)` Show shortened output
{enter} `(boolean?)` Enter output window
{quiet} `(boolean?)` Suppress warnings of no output
{last_run} `(boolean?)` Open output for last test run
{position_id} `(string?)` Open output for position with this ID, opens nearest
position if not given
{adapter} `(string?)` Adapter ID, defaults to first found with matching
position
{auto_close} `(boolean?)` Close output window when leaving it, or when cursor
moves outside of window

                                                         *neotest.output.open()*
`open`({opts})

Open the output of a test result
>vim
  lua require("neotest").output.open({ enter = true })
<
Parameters~
{opts?} `(neotest.consumers.output.OpenArgs)`


==============================================================================
neotest.output_panel                                      *neotest.output_panel*


A consumer that streams all output of tests to a terminal window.

                                                   *neotest.output_panel.open()*
`open`()

Open the output panel
>vim
  lua require("neotest").output_panel.open()
<

                                                  *neotest.output_panel.close()*
`close`()

Close the output panel
>vim
  lua require("neotest").output_panel.close()
<

                                                 *neotest.output_panel.toggle()*
`toggle`()

Toggle the output panel
>vim
  lua require("neotest").output_panel.toggle()
<

                                                  *neotest.output_panel.clear()*
`clear`()

Clears the output panel
>vim
  lua require("neotest").output_panel.clear()
<


==============================================================================
neotest.run                                                        *neotest.run*


A consumer providing a simple interface to run tests.

                                                           *neotest.run.RunArgs*
Inherits: `neotest.client.RunTreeArgs`

Fields~
{[1]} `(string?)` Position ID to run
{suite} `(boolean)` Run the entire suite instead of a single position

                                                             *neotest.run.run()*
`run`({args})

Run the given position or the nearest position if not given.
All arguments are optional

Run the current file
>vim
  lua require("neotest").run.run(vim.fn.expand("%"))
<

Run the nearest test
>vim
  lua require("neotest").run.run()
<

Debug the current file with nvim-dap
>vim
  lua require("neotest").run.run({vim.fn.expand("%"), strategy = "dap"})
<
Parameters~
{args} `(string|neotest.run.RunArgs?)` Position ID to run or args.

                                                        *neotest.run.run_last()*
`run_last`({args})

Re-run the last position that was run.
Arguments are optional

Run the last position that was run with the same arguments and strategy
>vim
  lua require("neotest").run.run_last()
<

Run the last position that was run with the same arguments but debug with
nvim-dap
>vim
  lua require("neotest").run.run_last({ strategy = "dap" })
<
Parameters~
{args} `(neotest.run.RunArgs?)` Argument overrides

                                                          *neotest.run.StopArgs*
Inherits: `neotest.client.StopArgs`

Fields~
{interactive} `(boolean)` Select a running position interactively

                                                            *neotest.run.stop()*
`stop`({args})

Stop a running process

Parameters~
{args} `(string|neotest.run.StopArgs?)` Position ID to stop or args. If
args then args[1] should be the position ID.

                                                        *neotest.run.AttachArgs*
Inherits: `neotest.client.AttachArgs`

Fields~
{interactive} `(boolean)` Select a running position interactively

                                                          *neotest.run.attach()*
`attach`({args})

Attach to a running process for the given position.

Parameters~
{args} `(string|neotest.run.AttachArgs?)` Position ID to attach to or args. If
args then
args[1] should be the position ID.

                                                    *neotest.run.get_last_run()*
`get_last_run`()

Get last test position ID and args
Return~
`(string|nil)` position_id
Return~
`(neotest.run.RunArgs|nil)` args


==============================================================================
neotest.watch                                                    *neotest.watch*


Allows watching tests and re-running them whenever related files are
changed. When watching a directory, all files are run in separate processes.
Otherwise the tests are run in the same process (if allowed by the adapter).

Related files are determined through an LSP client through a "best effort"
which means there are cases where a file may not be determined as related
despite it having an effect on a test.

To determine file relationships, a treesitter query is used to find symbols
that are queried for using the `textDocument/definition` LSP request. The
query can be configured through the watch consumer's config. Any captures
named `symbol` will be used. If your language is not present in the default
config, please submit a PR to add support out of the box!

                                                      *neotest.watch.WatchArgs:*
Fields~
{run_predicate?} `(fun(bufnr: integer):boolean)` Can be used to check whether
tests should be rerun

                                                         *neotest.watch.watch()*
`watch`({args})

Watch a position and run it whenever related files are changed.
Arguments are the same as the `neotest.run.run`, which allows
for custom runner arguments, env vars, strategy etc. If a position is
already being watched, the existing watcher will be stopped.
An additional `run_predicate` function, which takes a buffer handle,
can be passed in to determine whether tests should be rerun.
This can be useful, e.g. for only rerunning if there are no LSP
error diagnostics.
Parameters~
{args?} `(neotest.watch.WatchArgs|string)`

                                                        *neotest.watch.toggle()*
`toggle`({args})

Toggle watching a position and run it whenever related files are changed.
Arguments are the same as the `neotest.run.run`, which allows
for custom runner arguments, env vars, strategy etc.

Toggle watching the current file
>vim
  lua require("neotest").watch.toggle(vim.fn.expand("%"))
<
Parameters~
{args?} `(neotest.watch.WatchArgs|string)`

                                                          *neotest.watch.stop()*
`stop`({position_id})

Stop watching a position. If no position is provided, all watched positions are stopped.
Parameters~
{position_id} `(string)`

                                                   *neotest.watch.is_watching()*
`is_watching`({position_id})

Check if a position is being watched.
Parameters~
{position_id} `(string)`
Return~
`(boolean)`


==============================================================================
neotest.status                                                  *neotest.status*


A consumer that displays the results of tests as signs beside their declaration.
This consumer is completely passive and so has no interface.


==============================================================================
neotest.diagnostic                                          *neotest.diagnostic*


A consumer that displays error messages using the vim.diagnostic API.
This consumer is completely passive and so has no interface.

You can configure the diagnostic API for neotest using the "neotest" namespace
See also ~
|vim.diagnostic.config()|


==============================================================================
neotest.summary                                                *neotest.summary*


A consumer that displays the structure of the test suite, along with results and
allows running tests.
See also ~
|neotest.Config.summary.mappings| for all mappings in the summary window

                                                        *neotest.summary.open()*
`open`()

Open the summary window
>vim
  lua require("neotest").summary.open()
<

                                                       *neotest.summary.close()*
`close`()

Close the summary window
>vim
  lua require("neotest").summary.close()
<

                                                      *neotest.summary.toggle()*
`toggle`()

the summary window

>vim
 lua require("neotest").summary.toggle()
<

                                                *neotest.summmary.RunMarkedArgs*
Inherits: `neotest.run.RunArgs`


                                                  *neotest.summary.run_marked()*
`run_marked`({args})

Run all marked positions
Parameters~
{args?} `(neotest.summmary.RunMarkedArgs)`

                                                      *neotest.summary.marked()*
`marked`()

Return a table<adapter id, position_id[]> of all marked positions
@return table<string, string[]>

                                               *neotest.summary.ClearMarkedArgs*
Fields~
{adapter?} `(string)` Adapter ID, if not given all adapters are cleared

                                                *neotest.summary.clear_marked()*
`clear_marked`({args})

Clear all marked positions
Parameters~
{args?} `(neotest.summary.ClearMarkedArgs)`

                                                      *neotest.summary.target()*
`target`({adapter_id}, {position_id})

Set the target for an adapter tree
Parameters~
{adapter_id} `(string)`
{position_id} `(string|nil)` Position ID to target, nil to reset target


==============================================================================
neotest.jump                                                      *neotest.jump*


A consumer that allows jumping between tests

Example mappings to jump between test failures
>vim
  nnoremap <silent>[n <cmd>lua require("neotest").jump.prev({ status = "failed" })<CR>
  nnoremap <silent>]n <cmd>lua require("neotest").jump.next({ status = "failed" })<CR>
<

                                                         *neotest.jump.JumpArgs*
Fields~
{status} `(string)` Only jump to positions with given status

                                                           *neotest.jump.next()*
`next`({args})

Jump to the position after the cursor position in the current file
Parameters~
{args?} `(neotest.jump.JumpArgs)`

                                                           *neotest.jump.prev()*
`prev`({args})

to the position after the cursor position in the current file
Parameters~
{args?} `(neotest.jump.JumpArgs)`


==============================================================================
neotest.quickfix                                              *neotest.quickfix*


A consumer that sends results to the quickfix list.


==============================================================================
neotest.state                                                    *neotest.state*


A consumer that tracks various pieces of state in Neotest.
Most of the internals of Neotest are asynchronous so this consumer allows
tracking the state of the test suite and test results without needing to
write asynchronous code.

                                                   *neotest.state.adapter_ids()*
`adapter_ids`()

Get the list of all adapter IDs currently active
Return~
`(string[])`

                                                 *neotest.state.status_counts()*
`status_counts`({adapter_id}, {args})

Get the counts of the various states of tests for the entire suite or for a
buffer.
Parameters~
{adapter_id} `(string)`
{args?} `(neotest.state.StatusCountsArgs)`
Return~
`(neotest.state.StatusCounts)` | nil

                                                *neotest.state.StatusCountsArgs*
Fields~
{buffer?} `(integer)` Returns statuses for this buffer

                                                    *neotest.state.StatusCounts*
Fields~
{total} `(integer)`
{passed} `(integer)`
{failed} `(integer)`
{skipped} `(integer)`
{running} `(integer)`

                                                     *neotest.state.positions()*
`positions`({adapter_id}, {args})

Get the known positions for the entire suite or for a buffer.
Parameters~
{adapter_id} `(string)`
{args?} `(neotest.state.PositionsArgs)`
Return~
`(neotest.Tree)` | nil

                                                   *neotest.state.PositionsArgs*
Fields~
{buffer?} `(integer)` Returns positions for this buffer


==============================================================================
                                                                *neotest.Client*
`Client`


The neotest client is the core of neotest, it communicates with adapters,
running tests and collecting results.
Most of the client methods are async and so need to be run in an async
context (i.e. `require("nio").run(function() ... end))
The client starts lazily, meaning that no parsing of tests will be performed
until it is required. Care should be taken to not use the client methods on
start because it can slow down startup.
{listeners} `(neotest.ConsumerListeners)`

                                                     *neotest.ConsumerListeners*
Fields~
{discover_positions} `(fun(adapter_id: string, tree: neotest.Tree))`
{run} `(fun(adapter_id: string, root_id: string, position_ids: string[]))`
{results} `(fun(adapter_id: string, results: table<string, neotest.Result>,
partial: boolean))`
{test_file_focused} `(fun(adapter_id: string, file_path: string)>)`
{test_focused} `(fun(adapter_id: string, position_id: string)>)`
{starting} `(fun())`
{started} `(fun())`
Type ~
neotest.Client

                                                    *neotest.client.RunTreeArgs*
Fields~
{adapter?} `(string)` Adapter ID, if not given the first adapter found with
chosen position is used.
{strategy?} `("integrated"|"dap"|string|neotest.Strategy)` Strategy to run
commands with
{extra_args?} `(string[])` Arguments supplied to the test adapter to add to
the test process arguments
{env?} `(table<string, string>)` Environment variables for the test process
{cwd?} `(string)` Working directory for the test process
{concurrent?} `(false|number)` Override concurrency settings for running tests

                                                     *neotest.Client:run_tree()*
`Client:run_tree`({tree}, {args})

Run the given tree

Parameters~
{tree} `(neotest.Tree)`
{args} `(neotest.client.RunTreeArgs)`

                                            *neotest.Client:running_positions()*
`Client:running_positions`()

Return~
`(table[])`

                                                       *neotest.client.StopArgs*
Fields~
{adapter} `(string)` Adapter ID

                                                         *neotest.Client:stop()*
`Client:stop`({position}, {args})


Parameters~
{position} `(neotest.Tree)`
{args?} `(neotest.client.StopArgs)`

                                                     *neotest.client.AttachArgs*
Fields~
{adapter} `(string)` Adapter ID

                                                       *neotest.Client:attach()*
`Client:attach`({position}, {args})

Attach to the given running position.

Parameters~
{position} `(neotest.Tree)`
{args?} `(neotest.client.AttachArgs)`

                                                 *neotest.client.GetNearestArgs*
Fields~
{adapter} `(string)` Adapter ID

                                                  *neotest.Client:get_nearest()*
`Client:get_nearest`({file_path}, {row}, {args})


Parameters~
{file_path} `(string)`
{row} `(integer)` Zero-indexed row
{args} `(neotest.client.GetNearestArgs)`
Return~
`(neotest.Tree|nil,string|nil)`

                                                 *neotest.Client:get_adapters()*
`Client:get_adapters`()

all known active adapters

Return~
`(string[])`

                                                *neotest.client.GetPositionArgs*
Fields~
{adapter?} `(string)` Adapter ID

                                                 *neotest.Client:get_position()*
`Client:get_position`({position_id}, {args})


Parameters~
{position_id?} `(string)`
{args} `(neotest.client.GetPositionArgs)`
Return~
`(neotest.Tree|nil,string|nil)`

                                                  *neotest.Client:get_results()*
`Client:get_results`({adapter})

Parameters~
{adapter} `(string)` Adapter ID
Return~
`(table<string, neotest.Result>)`

                                                  *neotest.client.IsRunningArgs*
Fields~
{adapter} `(string)` Adapter ID

                                                   *neotest.Client:is_running()*
`Client:is_running`({position_id}, {args})

Parameters~
{position_id} `(string)`
{args} `(neotest.client.IsRunningArgs)`
Return~
`(boolean)`

                                                  *neotest.Client:get_adapter()*
`Client:get_adapter`({file_path})


Parameters~
{file_path} `(string)`
Return~
`(string?)`
Return~
`(neotest.Adapter?)`


==============================================================================
neotest.lib                                                        *neotest.lib*


Neotest provides several modules that can be used for common tasks.
Some of the modules are quite generic while others are highly tailored to
building adapters or consumers.

The libraries are not meant for general users but are treated as a
public API and so will remain mostly stable. The libraries should only be
used by accessing require("neotest.lib"). The module structure within the
library is considered private and may change without notice.


==============================================================================
neotest.lib.files                                            *neotest.lib.files*


Helper functions for interacting with files

                                                      *neotest.lib.files.read()*
`read`({file_path})

Read a file asynchronously

Parameters~
{file_path} `(string)`
Return~
`(string)`

                                                     *neotest.lib.files.write()*
`write`({file_path}, {data})

Write to a file asynchronously
Parameters~
{file_path} `(string)`
{data} `(string)`

                                                *neotest.lib.files.read_lines()*
`read_lines`({file_path})

Read a file asynchronously, splitting the content into lines

Parameters~
{file_path} `(string)`
Return~
`(string[])`

                                               *neotest.lib.files.split_lines()*
`split_lines`({data_iterator})

Splits an async iterator of strings into lines. This is useful for data coming
from a process where the data can be split randomly

Parameters~
{data_iterator} `(fun(): string)`
Return~
`(fun(): string[])`

                                                    *neotest.lib.files.stream()*
`stream`({file_path})

Streams data from a file, watching for new data over time
Only works when data is exlusively added and not deleted from the file
Useful for watching a file which is written to by another process.

Parameters~
{file_path} `(string)`
Return~
`(fun(): string)` Iterator
Return~
`(function)` Callback to stop streaming

                                              *neotest.lib.files.stream_lines()*
`stream_lines`({file_path})

Stream data from a file over time, splitting the content into lines
Parameters~
{file_path} `(string)`
Return~
`(fun(): string[])` Iterator
Return~
`(fun())` Callback to stop streaming

                                                    *neotest.lib.files.exists()*
`exists`({path})

Check if a path exists
Parameters~
{path} `(string)`
Return~
`(boolean,string|nil)`

                                                    *neotest.lib.files.is_dir()*
`is_dir`({path})

Check if a path is a directory
Parameters~
{path} `(string)`
Return~
`(boolean)`

                                                 *neotest.lib.files.FindOptions*
Fields~
{filter_dir} `(fun(name: string, rel_path: string, root: string): boolean)`
Filter directories to be searched

                                                      *neotest.lib.files.find()*
`find`({root}, {opts})

Find all files under the given directory.
Does not search hidden directories.

Parameters~
{root} `(string)`
{opts} `(neotest.lib.files.FindOptions)`
Return~
`(string[])` @Absolute paths of all files within directories to search

                                                    *neotest.lib.files.parent()*
`parent`({path})

Get the parent directory of a path
Parameters~
{path} `(string)`
Return~
`(string)`

neotest.lib.files.sep                                    *neotest.lib.files.sep*

Path separator for the current OS
Type ~
`(string)`

                                           *neotest.lib.files.detect_filetype()*
`detect_filetype`({path})

Detect the filetype of a file by checking the name, extensions, shebang or
modeline. This is a memoized wrapper around plenary's filetype detection.
Parameters~
{path} `(string)`
Return~
`(string)`

                                      *neotest.lib.files.parse_dir_from_files()*
`parse_dir_from_files`({root}, {files})

Parse a sorted list of file paths into a position tree
Parameters~
{files} `(string[])` List of files to include in directory tree, along with
parents
Return~
`(neotest.Tree)`

                                        *neotest.lib.files.match_root_pattern()*
`match_root_pattern`({...})

Create a function that will take directory and attempt to match the provided
glob patterns against the contents of the directory.
Parameters~
{...} `(string)` Patterns to match e.g "*.py"
Return~
`(fun(path: string): string)` | nil


==============================================================================
neotest.lib.func_util                                    *neotest.lib.func_util*


Miscellaneous functions for working with functions.
Many of the functions have both a table and list variant.

                                                   *neotest.lib.func_util.map()*
`map`({f}, {t})

Map over the values in a table
Parameters~
{f} `(fun(k: any, v: any): K,)` V
{t} `(table)`
Return~
`(table<K, V>)`

                                              *neotest.lib.func_util.map_list()*
`map_list`({f}, {t})

Map over the values in a list
Parameters~
{f} `(fun(i: integer, v: any): V)`
{t} `(table)`
Return~
`(V[])`

                                                *neotest.lib.func_util.filter()*
`filter`({f}, {t})

Filter elements from a table
Parameters~
{f} `(fun(k: K, v: V): boolean)`
{t} `(table<K, V>)`
Return~
`(table<K, V>)`

                                           *neotest.lib.func_util.filter_list()*
`filter_list`({f}, {t})

Filter elements from a list
Parameters~
{f} `(fun(v: V): boolean)`
{t} `(V[])`
Return~
`(V[])`

                                               *neotest.lib.func_util.reverse()*
`reverse`({list})

Reverse a list, as an interator
Parameters~
{list} `(E[])`
Return~
`(fun(): E)`

                                                 *neotest.lib.func_util.index()*
`index`({list}, {item})

Search a list for an element
Parameters~
{list} `(V[])`
{item} `(V)`
Return~
`(integer)` | nil

                                               *neotest.lib.func_util.to_list()*
`to_list`({iter})

Convert an iterator to a list
Parameters~
{iter} `(fun(): E)`
Return~
`(E[])`

                                               *neotest.lib.func_util.partial()*
`partial`({func}, {...})

Partially apply arguments to a function
Parameters~
{func} `(function)`
{...} `(any)` Arguments to pass to func
Return~
`(function)`


==============================================================================
neotest.lib.positions                                    *neotest.lib.positions*


Functions for interacting with positions and position trees

                                               *neotest.lib.positions.nearest()*
`nearest`({tree}, {line})

Get the nearest position to the given line in the provided file tree
Parameters~
{tree} `(neotest.Tree)`
{line} `(integer)`
Return~
`(neotest.Tree)`

                                              *neotest.lib.positions.contains()*
`contains`({parent}, {child})

Check if a positions is contained by another. Assumes that both positions exist on the file system, meaning they are files,
directories or have a range attribute specified.
Parameters~
{parent} `(neotest.Position)`
{child} `(neotest.Position)`
Return~
`(boolean)`

                                                                  *get_parent()*
`get_parent`({position})

Parameters~
{position} `(neotest.Position)`
Return~
`(neotest.Position)`

                                                            *wrap_with_parent()*
`wrap_with_parent`({tree})

Parameters~
{tree} `(neotest.Tree)`
Return~
`(neotest.Tree)`

                                                   *get_or_create_parent_node()*
`get_or_create_parent_node`({dir_tree}, {new_tree})

Parameters~
{dir_tree} `(neotest.Tree)`
{new_tree} `(neotest.Tree)`
Return~
`(neotest.Tree)`

                                                                *replace_node()*
`replace_node`({tree}, {node})

Parameters~
{tree} `(neotest.Tree)`
{node} `(neotest.Tree)`

                                                            *update_file_node()*
`update_file_node`({dir_tree}, {file_tree}, {force})

Parameters~
{dir_tree} `(neotest.Tree)`
{file_tree} `(neotest.Tree)`

                                            *neotest.lib.positions.ParseOptions*
Fields~
{nested_tests} `(boolean)` Allow nested tests
{require_namespaces} `(boolean)` Require tests to be within namespaces
{position_id} `(fun(position: neotest.Position, parents: neotest.Position[]):
string)` Position ID constructor

                                            *neotest.lib.positions.parse_tree()*
`parse_tree`({positions}, {opts})

Convert a flat list of sorted positions to a tree. Positions ID fields can be nil as they will be assigned.
NOTE: This mutates the positions given by assigning the `id` field.
Parameters~
{positions} `(neotest.Position[])`
{opts} `(neotest.lib.positions.ParseOptions)`
Return~
`(neotest.Tree)`


==============================================================================
neotest.lib.treesitter                                  *neotest.lib.treesitter*


Functions to help parse files with treesitter, optimised for test parsing.

                                           *neotest.lib.treesitter.fast_parse()*
`fast_parse`({lang_tree})

Injections take a long time to run and are not needed.
This does only the required parsing
Replaces `LanguageTree:parse`
https://github.com/neovim/neovim/blob/master/runtime/lua/vim/treesitter/languagetree.lua

                                           *neotest.lib.treesitter.ParseOptions*
Inherits: `neotest.lib.positions.ParseOptions`

Fields~
{fast?} `(boolean)` Use faster parsing (Should be unchanged unless injections
are needed)
{build_position?} `(fun(file_path: string, source: string, captured_nodes:
table<string, userdata>): neotest.Position|neotest.Position[]|nil)` Builds one
or more positions from the captured nodes from a query match.

                                      *neotest.lib.treesitter.normalise_query()*
`normalise_query`({lang}, {query})

Build a parsed Query object from a string
Parameters~
{lang} `(string)`
{query} `(table|string)`
Return~
`(table)`

                                       *neotest.lib.treesitter.get_parse_root()*
`get_parse_root`({file_path}, {content}, {opts})

Return a treesitter tree root for file_path and the TreeSitter lang value for it
Parameters~
{file_path} `(string)`
{content} `(string)`
{opts} `(neotest.lib.treesitter.ParseOptions)`
Return~
`(userdata,string)`

                          *neotest.lib.treesitter.parse_positions_from_string()*
`parse_positions_from_string`({file_path}, {content}, {query}, {opts})

Same as `parse_positions` but uses the provided content instead of reading file.
Do not use this directly unless you have a good reason. `parse_positions` is preferred
because it will parse in a subprocess and thus will never block the current editor instance.
Parameters~
{file_path} `(string)`
{content} `(string)`
{query} `(table|string)`
{opts} `(neotest.lib.treesitter.ParseOptions)`
Return~
`(neotest.Tree)`

                                      *neotest.lib.treesitter.parse_positions()*
`parse_positions`({file_path}, {query}, {opts})

Read a file's contents from disk and parse test positions using the given query.
Executed in a subprocess to avoid blocking the editor if possible.
Since functions can't be serialised for RPC the build_position and position_id options
can be strings that will evaluate to globally referencable functions
(e.g. `'require("my_adapter")._build_position'`).

Parameters~
{file_path} `(string)`
{query} `(string)`
{opts} `(neotest.lib.treesitter.ParseOptions)`
Return~
`(neotest.Tree)`


==============================================================================
neotest.lib.process                                        *neotest.lib.process*


Utilities to run external processes easily.
More complex use cases should use the lower level jobstart or vim.loop.spawn

                                                   *neotest.lib.process.RunArgs*
Fields~
{stdout} `(boolean)` Read stdout
{stderr} `(boolean)` Read stderr

                                                 *neotest.lib.process.RunResult*
Fields~
{stdout?} `(string)`
{stderr?} `(string)`

                                                     *neotest.lib.process.run()*
`run`({command}, {args})

Runs a process using libuv. This is designed for a simple, quick async
alternative to io.popen and so will wait until the process exits to read
the stdout/stderr. Do not use this for long running jobs or for large
outputs. Use vim.jobstart instead.

Parameters~
{command} `(string[])`
{args?} `(neotest.lib.process.RunArgs)`
Return~
`(integer,neotest.lib.process.RunResult)` Exit code and table containing stdout/stderr keys if requested


==============================================================================
neotest.lib.xml                                                *neotest.lib.xml*


Library to parse XML strings.
Originially taken from https://github.com/manoelcampos/xml2lua

                                                       *neotest.lib.xml.parse()*
`parse`({xml_data})

Parameters~
{xml_data} `(string)`
Return~
`(table)`


==============================================================================
                                                                  *neotest.Tree*
`Tree`

Nested tree structure with nodes containing data and having any
number of children

                                                      *neotest.Tree.from_list()*
`from_list`({data}, {key})

Parses a tree in the shape of nested lists.
The head of the list is the root of the tree, and all following elements are its children.
Parameters~
{data} `(any[])`
Return~
`(neotest.Tree)`

                                                        *neotest.Tree:to_list()*
`Tree:to_list`()

Returns the tree as a nested list which can be parsed by the `from_list`
method
Return~
`(any[])`

                                                        *neotest.Tree:get_key()*
`Tree:get_key`({key})

Parameters~
{key} `(any)`
Return~
`(neotest.Tree)` | nil

                                                           *neotest.Tree:data()*
`Tree:data`()

Return~
`(neotest.Position)`

                                                       *neotest.Tree:children()*
`Tree:children`()

Return~
`(neotest.Tree[])`

                                                         *neotest.Tree:parent()*
`Tree:parent`()

Return~
`(neotest.Tree)` | nil

                                                   *neotest.Tree:iter_parents()*
`Tree:iter_parents`()

Return~
`(fun(): neotest.Tree)`

                                              *neotest.Tree:closest_node_with()*
`Tree:closest_node_with`({data_attr})

Fetch the first node ascending the tree (including the current one) with the
given data attribute e.g. `range`
Parameters~
{data_attr} `(string)`
Return~
`(neotest.Tree)` | nil

                                              *neotest.Tree:closest_value_for()*
`Tree:closest_value_for`({data_attr})

Fetch the first non-nil value for the given data attribute ascending the
tree (including the current node) with the given data attribute.
Parameters~
{data_attr} `(string)`
Return~
`(any)` | nil

                                                           *neotest.Tree:root()*
`Tree:root`()

Return~
`(neotest.Tree)`

                                              *neotest.types.tree.IterNodesArgs*
Fields~
{continue} `(fun(node: neotest.Tree): boolean)` A predicate for if the given
node's children should be iterated over.  Defaults to `true`.

                                                     *neotest.Tree:iter_nodes()*
`Tree:iter_nodes`({args})

Parameters~
{args?} `(neotest.types.tree.IterNodesArgs)`
Return~
`(fun():integer,neotest.Tree)`

                                                           *neotest.Tree:iter()*
`Tree:iter`({args})

Parameters~
{args?} `(neotest.types.tree.IterNodesArgs)`
Return~
`(fun():integer,neotest.Position)`

                                                           *neotest.Tree:node()*
`Tree:node`({index})

Parameters~
{index} `(integer)`


==============================================================================
                                                           *neotest.FanoutAccum*
`FanoutAccum`

Accumulates provided data and stores it, while sending to consumers.
Allows consuming all data ever pushed while subscribing at any point in time.
Fields~
{consumers} `(fun(data: T)[])`
{data?} `(T)`
{accum} `(fun(prev: T, new: any): T)` A function to combine previous data and
new data

                                                     *neotest.FanoutAccum:new()*
`FanoutAccum:new`({accum}, {init})

Parameters~
{accum} `(fun(prev: T, new: any): T)`
{init} `(T)`
Return~
`(neotest.FanoutAccum)`

                                               *neotest.FanoutAccum:subscribe()*
`FanoutAccum:subscribe`({cb})

Parameters~
{cb} `(fun(data: T): boolean|nil)`

                                                    *neotest.FanoutAccum:push()*
`FanoutAccum:push`({data})

Parameters~
{data} `(T)`


==============================================================================
                                                                *M.PositionType*
`PositionType`

neotest.PositionType

                                                              *neotest.Position*
Fields~
{id} `(string)`
{type} `(neotest.PositionType)`
{name} `(string)`
{path} `(string)`
{range} `(integer[])`

                                                                *M.ResultStatus*
`ResultStatus`

neotest.ResultStatus

                                                                *neotest.Result*
Fields~
{status} `(neotest.ResultStatus)`
{output?} `(string)` Path to file containing full output data
{short?} `(string)` Shortened output string
{errors?} `(neotest.Error[])`

                                                                 *neotest.Error*
Fields~
{message} `(string)`
{line?} `(integer)`

                                                               *neotest.Process*
Fields~
{output} `(async fun(): string)` Path to file containing output data
{is_complete} `(fun())` boolean Is process complete
{result} `(async fun())` integer Get result code of process (async)
{attach} `(async fun())` Attach to the running process for user input
{stop} `(async fun())` Stop the running process
{output_stream} `(async fun(): async)` fun(): string Async iterator of process
output

                                                       *neotest.StrategyContext*
Fields~
{position} `(neotest.Position)`
{adapter} `(neotest.Adapter)`

                                                              *neotest.Strategy*
Alias~
`neotest.Strategy` → `async fun(spec: neotest.RunSpec, context: neotest.StrategyContext): neotest.Process`

                                                        *neotest.StrategyResult*
Fields~
{code} `(integer)`
{output} `(string)`

                                                               *neotest.RunArgs*
Fields~
{tree} `(neotest.Tree)`
{extra_args?} `(string[])`
{strategy} `(string)`

                                                               *neotest.RunSpec*
Fields~
{command} `(string[])`
{env?} `(table<string, string>)`
{cwd?} `(string)`
{context?} `(table)` Arbitrary data to preserve state between running and
result collection
{strategy?} `(table|neotest.Strategy)` Arguments for strategy or override for
chosen strategy
{stream} `(fun(output_stream: fun(): string[]): fun():)` table<string,
neotest.Result>
]]