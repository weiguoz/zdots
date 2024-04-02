# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

from __future__ import (absolute_import, division, print_function)

# You can import any python module as needed.
import os

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command


# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!
class my_edit(Command):
    # The so-called doc-string of the class will be visible in the built-in
    # help that is accessible by typing "?c" inside ranger.
    """:my_edit <filename>

    A sample command for demonstration purposes that opens a file in an editor.
    """

    # The execute method is called when you run this command in ranger.
    def execute(self):
        # self.arg(1) is the first (space-separated) argument to the function.
        # This way you can write ":my_edit somefilename<ENTER>".
        if self.arg(1):
            # self.rest(1) contains self.arg(1) and everything that follows
            target_filename = self.rest(1)
        else:
            # self.fm is a ranger.core.filemanager.FileManager object and gives
            # you access to internals of ranger.
            # self.fm.thisfile is a ranger.container.file.File object and is a
            # reference to the currently selected file.
            target_filename = self.fm.thisfile.path

        # This is a generic function to print text in ranger.
        self.fm.notify("Let's edit the file " + target_filename + "!")

        # Using bad=True in fm.notify allows you to print error messages:
        if not os.path.exists(target_filename):
            self.fm.notify("The given file does not exist!", bad=True)
            return

        # This executes a function from ranger.core.acitons, a module with a
        # variety of subroutines that can help you construct commands.
        # Check out the source, or run "pydoc ranger.core.actions" for a list.
        self.fm.edit_file(target_filename)

    # The tab method is called when you press tab, and should return a list of
    # suggestions that the user will tab through.
    # tabnum is 1 for <TAB> and -1 for <S-TAB> by default
    def tab(self, tabnum):
        # This is a generic tab-completion function that iterates through the
        # content of the current directory.
        return self._tab_directory_content()


class customized_fd(Command):
    """
    :fzf_select
    Find a file using fzf.
    With a prefix argument select only directories.
    See: https://github.com/junegunn/fzf
    """
    def execute(self):
      import subprocess
      import os.path
      if self.quantifier:
          # match only directories
          command = 'fd -I --type d --hidden --follow -E ".git" -E "node_modules" . | fzf +m'
      else:
          # match files and directories
          command = 'fd -I --hidden --follow -E ".git" -E "node_modules" . | fzf +m'
      fzf = self.fm.execute_command(command,
                                    universal_newlines=True,
                                    stdout=subprocess.PIPE)
      stdout, stderr = fzf.communicate()
      if fzf.returncode == 0:
          fzf_file = os.path.abspath(stdout.rstrip('\n'))
          if os.path.isdir(fzf_file):
              self.fm.cd(fzf_file)
          else:
              self.fm.select_file(fzf_file)


class customized_rg(Command):
    """
    :fzf_rga_search_documents
    Search in PDFs, E-Books and Office documents in current directory.
    Allowed extensions: .epub, .odt, .docx, .fb2, .ipynb, .pdf.

    Usage: fzf_rga_search_documents <search string>
    """
    def execute(self):
        if self.arg(1):
            search_string = self.rest(1)
        else:
            self.fm.notify("Usage: fzf_rga_search_documents <search string>", bad=True)
            return

        import subprocess
        import os.path
        from ranger.container.file import File
        command_fmt="rg --files-with-matches --smart-case --multiline --no-ignore"
        command="%s '%s' | fzf --sort --preview='[[ ! -z {} ]] && rg --pretty --context 10 {q} {}' --phony -q '%s' --bind 'change:reload:%s {q}'" % (command_fmt, search_string, search_string, command_fmt)

        fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            self.fm.execute_file(File(fzf_file))


class tmux_open(Command):
    """
    :tmux_open

    Open a file with vim in a new tmux window if it's a file,
    or change directory in a new tmux window if it's a directory.
    """
    def execute(self):
        if self.fm.thisfile.is_directory:
            tmux_command = f"tmux new-window -c {self.fm.thisfile.path}"
        else:
            # will close tmux window if quit vim
            tmux_command = f"tmux new-window -c {self.fm.thisdir.path} nvim {self.fm.thisfile.path}"
            # keep tmux window stay if quit vim
            # tmux_command = f"tmux new-window -c {self.fm.thisdir.path} \\; send-keys 'nvim \"{self.fm.thisfile.path}\"; clear' C-m"
        self.fm.execute_command(tmux_command, flags='f')

