syntax region pddlcomment start=/\s*;/ end=/$/
syntax match pddldefinition '\<\(define\|domain\|problem\)\>\c'
syntax match pddloperator '\<\(and\|or\|not\|forall\|when\)\>\c'
syntax match pddloperatormat '[ (]\zs[-+*/=<>]\+'
syntax match pddlkeyword ':\(requirements\|types\|predicates\|constants\|action\|durative-action\|domain\|parameters\|precondition\|effect\|objects\|init\|goal\|functions\|duration\|condition\|derived\|metric\)\c'

" link syntax groups to highlighting groups
highlight def link pddlcomment comment
highlight def link pddlkeyword keyword
highlight def link pddldefinition special
highlight def link pddloperator precondit
highlight def link pddloperatormat precondit
