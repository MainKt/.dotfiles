vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function()

    use "wbthomason/packer.nvim"
    
    use "preservim/vim-colors-pencil"

    use "folke/tokyonight.nvim"

    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.0",
        requires = { { "nvim-lua/plenary.nvim" } }
    }
    
    use "Shougo/deoplete.nvim"

end)
