from building import *

# get current directory
cwd  = GetCurrentDir()
src  = Glob('utils/*.c')
path = [cwd + '/jerryscript/jerry-core/include', 
	cwd + '/jerryscript/jerry-ext/include',
	cwd + '/jerryscript/jerry-port/include'
]

group = DefineGroup('JerryScript', src, depend = ['PKG_USING_JERRYSCRIPT_WIN32'], CPPPATH = path)

Return('group')
