-- Default curves and animations, see https://wiki.hypr.land/configuring/core/animations/
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("smooth", { type = "spring", mass = 1, stiffness = 246.7401, damping = 31.41593 })

hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "smooth" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "smooth", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 85%" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, spring = "smooth", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, spring = "smooth", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, spring = "smooth", style = "slide" })
