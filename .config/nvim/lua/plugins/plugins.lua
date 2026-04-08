return {
	{ "echasnovski/mini.files", version = "*" },
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				puppet = { "puppet-lint" },
			},
			formatters = {
				["puppet-lint"] = {
					prepend_args = { "--no-top_scope_facts" },
				},
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)

			-- Add a keymap to format the current buffer
			vim.keymap.set("n", "<leader>f", function()
				require("conform").format({ lsp_fallback = true })
			end, { desc = "Format buffer" })
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.diagnostic.config({
				signs = true, -- Show signs in the sign column
				underline = true, -- Underline text with issues
				update_in_insert = true, -- Update diagnostics in insert mode
				severity_sort = true, -- Sort by severity
			})
			vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]])
			vim.opt.updatetime = 300

			if vim.lsp and vim.lsp.config then
				vim.lsp.config("puppet", {
					capabilities = capabilities,
				})
				vim.lsp.enable("puppet")
			else
				require("lspconfig").puppet.setup({
					capabilities = capabilities,
				})
			end
		end,
	},
	{ "mason-org/mason.nvim", opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = { { "mason-org/mason.nvim", opts = {} }, "neovim/nvim-lspconfig" },
	},
	{ "ThePrimeagen/vim-be-good" },
}
