if !has("python")
    finish
endif

python << EOF
from rope.base.exceptions import BadIdentifierError
from ropevim import _env, _interface
from ropemode.interface import _CodeAssist

class OmniCompleter(object):
    def create_code_assist(self):
        return _CodeAssist(_interface, _interface.env)

    def __call__(self, findstart, base):
        try:
            if findstart:
                self.code_assist = self.create_code_assist()
                base_len = self.code_assist.offset - \
                           self.code_assist.starting_offset
                return int(vim.eval("col('.')")) - base_len - 1
            else:
                try:
                    proposals = self.code_assist._calculate_proposals()
                except Exception:
                    return []
                if vim.eval("complete_check()") != "0":
                    return []

                ps = [_env._extended_completion(p) for p in proposals]
                del self.code_assist

                return _env._vim_string(ps)
        except BadIdentifierError:
            del self.code_assist
            if findstart:
                return -1
            else:
                return []

ropecompleter = OmniCompleter()
EOF

function! RopeCompleteFunc(findstart, base)
python << EOF
findstart = int(vim.eval("a:findstart"))
base = vim.eval("a:base")
vim.command("return %s" % ropecompleter(findstart, base))
EOF
endfunction

