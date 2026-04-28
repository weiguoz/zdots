return {
    "pk-hash/smart-im.nvim",
    event = "InsertEnter",
    config = function()
        require("smart-im").setup({
            -- 先安装 macism，安装方法：
            -- brew tap laishulu/homebrew 
            --   && brew install macism
            --   && brew untap --force laishulu/homebrew
            get_im_cmd = "macism",
            set_im_cmd = "macism %s",
            -- default_im = "com.apple.keylayout.ABC" OR "c.a.k.US"
        })
    end,
}
