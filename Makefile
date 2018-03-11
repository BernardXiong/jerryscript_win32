CC      = gcc
OBJS    = \
	jerryscript/jerry-ext/handler/handler-print.o \
	jerryscript/jerry-ext/handler/handler-register.o \
	jerryscript/jerry-ext/handler/handler-assert.o \
	jerryscript/jerry-ext/handler/handler-gc.o \
	jerryscript/jerry-ext/arg/arg.o \
	jerryscript/jerry-ext/arg/arg-transform-functions.o \
	jerryscript/jerry-ext/arg/arg-js-iterator-helper.o \
	jerryscript/jerry-ext/module/module.o \
	jerryscript/jerry-core/ecma/base/ecma-property-hashmap.o \
	jerryscript/jerry-core/ecma/base/ecma-gc.o \
	jerryscript/jerry-core/ecma/base/ecma-helpers-number.o \
	jerryscript/jerry-core/ecma/base/ecma-helpers-string.o \
	jerryscript/jerry-core/ecma/base/ecma-helpers.o \
	jerryscript/jerry-core/ecma/base/ecma-helpers-value.o \
	jerryscript/jerry-core/ecma/base/ecma-helpers-values-collection.o \
	jerryscript/jerry-core/ecma/base/ecma-helpers-errol.o \
	jerryscript/jerry-core/ecma/base/ecma-literal-storage.o \
	jerryscript/jerry-core/ecma/base/ecma-init-finalize.o \
	jerryscript/jerry-core/ecma/base/ecma-lcache.o \
	jerryscript/jerry-core/ecma/base/ecma-alloc.o \
	jerryscript/jerry-core/ecma/base/ecma-helpers-conversion.o \
	jerryscript/jerry-core/ecma/base/ecma-helpers-external-pointers.o \
	jerryscript/jerry-core/ecma/operations/ecma-promise-object.o \
	jerryscript/jerry-core/ecma/operations/ecma-typedarray-object.o \
	jerryscript/jerry-core/ecma/operations/ecma-number-arithmetic.o \
	jerryscript/jerry-core/ecma/operations/ecma-get-put-value.o \
	jerryscript/jerry-core/ecma/operations/ecma-string-object.o \
	jerryscript/jerry-core/ecma/operations/ecma-arraybuffer-object.o \
	jerryscript/jerry-core/ecma/operations/ecma-reference.o \
	jerryscript/jerry-core/ecma/operations/ecma-conversion.o \
	jerryscript/jerry-core/ecma/operations/ecma-eval.o \
	jerryscript/jerry-core/ecma/operations/ecma-array-object.o \
	jerryscript/jerry-core/ecma/operations/ecma-regexp-object.o \
	jerryscript/jerry-core/ecma/operations/ecma-comparison.o \
	jerryscript/jerry-core/ecma/operations/ecma-jobqueue.o \
	jerryscript/jerry-core/ecma/operations/ecma-number-object.o \
	jerryscript/jerry-core/ecma/operations/ecma-boolean-object.o \
	jerryscript/jerry-core/ecma/operations/ecma-exceptions.o \
	jerryscript/jerry-core/ecma/operations/ecma-function-object.o \
	jerryscript/jerry-core/ecma/operations/ecma-objects.o \
	jerryscript/jerry-core/ecma/operations/ecma-objects-arguments.o \
	jerryscript/jerry-core/ecma/operations/ecma-lex-env.o \
	jerryscript/jerry-core/ecma/operations/ecma-objects-general.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-referenceerror-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-function.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-function-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-helpers-date.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-evalerror-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-error.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-regexp-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-int16array.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-float32array.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-int8array-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-uint8array.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-float32array-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-uint32array.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-uint8clampedarray-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-int8array.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-typedarray.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-int16array-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-float64array-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-uint8array-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-uint8clampedarray.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-uint32array-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-int32array.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-uint16array.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-typedarray-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-int32array-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-float64array.o \
	jerryscript/jerry-core/ecma/builtin-objects/typedarray/ecma-builtin-uint16array-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-syntaxerror-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-evalerror.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-syntaxerror.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-math.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-global.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-referenceerror.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-promise.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-typeerror-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-helpers-error.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-object-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-typeerror.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-arraybuffer.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-regexp.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-helpers.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-boolean-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-arraybuffer-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-date.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-rangeerror.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-boolean.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-array-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-urierror-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-string-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-string.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-number.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-json.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-promise-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-error-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-helpers-json.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-array.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-urierror.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-object.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-rangeerror-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtins.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-type-error-thrower.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-date-prototype.o \
	jerryscript/jerry-core/ecma/builtin-objects/ecma-builtin-number-prototype.o \
	jerryscript/jerry-core/parser/js/js-parser-scanner.o \
	jerryscript/jerry-core/parser/js/js-parser-util.o \
	jerryscript/jerry-core/parser/js/common.o \
	jerryscript/jerry-core/parser/js/js-lexer.o \
	jerryscript/jerry-core/parser/js/js-parser-statm.o \
	jerryscript/jerry-core/parser/js/js-parser.o \
	jerryscript/jerry-core/parser/js/js-parser-mem.o \
	jerryscript/jerry-core/parser/js/byte-code.o \
	jerryscript/jerry-core/parser/js/js-parser-expr.o \
	jerryscript/jerry-core/parser/regexp/re-compiler.o \
	jerryscript/jerry-core/parser/regexp/re-bytecode.o \
	jerryscript/jerry-core/parser/regexp/re-parser.o \
	jerryscript/jerry-core/lit/lit-char-helpers.o \
	jerryscript/jerry-core/lit/lit-magic-strings.o \
	jerryscript/jerry-core/lit/lit-strings.o \
	jerryscript/jerry-core/jmem/jmem-heap.o \
	jerryscript/jerry-core/jmem/jmem-poolman.o \
	jerryscript/jerry-core/jmem/jmem-allocator.o \
	jerryscript/jerry-core/api/jerry.o \
	jerryscript/jerry-core/api/jerry-debugger.o \
	jerryscript/jerry-core/api/jerry-snapshot.o \
	jerryscript/jerry-core/jcontext/jcontext.o \
	jerryscript/jerry-core/vm/vm-stack.o \
	jerryscript/jerry-core/vm/opcodes.o \
	jerryscript/jerry-core/vm/vm.o \
	jerryscript/jerry-core/vm/opcodes-ecma-bitwise.o \
	jerryscript/jerry-core/vm/opcodes-ecma-arithmetics.o \
	jerryscript/jerry-core/vm/opcodes-ecma-relational-equality.o \
	jerryscript/jerry-core/debugger/debugger.o \
	jerryscript/jerry-core/debugger/debugger-ws.o \
	jerryscript/jerry-core/debugger/debugger-sha1.o \
	jerryscript/jerry-core/jrt/jrt-fatals.o \
	port/win32_port.o

CFLAGS = -fno-exceptions -Wall -o2 -m32
INC    = -Ijerryscript -Ijerryscript/jerry-core	\
	-Ijerryscript/jerry-core/api		\
	-Ijerryscript/jerry-core/debugger		\
	-Ijerryscript/jerry-core/ecma/base		\
	-Ijerryscript/jerry-core/ecma/builtin-objects \
	-Ijerryscript/jerry-core/ecma/builtin-objects/typedarray \
	-Ijerryscript/jerry-core/ecma/operations	\
	-Ijerryscript/jerry-core/include		\
	-Ijerryscript/jerry-core/jcontext		\
	-Ijerryscript/jerry-core/jmem		\
	-Ijerryscript/jerry-core/jrt		\
	-Ijerryscript/jerry-core/lit		\
	-Ijerryscript/jerry-core/parser/js		\
	-Ijerryscript/jerry-core/parser/regexp	\
	-Ijerryscript/jerry-core/vm			\
	-Ijerryscript/jerry-ext/arg			\
	-Ijerryscript/jerry-ext/handler		\
	-Ijerryscript/jerry-ext/include \
	-Ijerryscript/jerry-ext/module \
	-Iport

TARGET  = libengine.dll

all: $(TARGET)

$(TARGET): $(OBJS)
	rm -f $(TARGET)
	$(CC) -shared -o $(TARGET) $(OBJS) -m32 -Wl,--kill-at,--output-def,libengine.def,--out-implib,libengine.a

.c.o:
	$(CC) -c $(INC) $(CFLAGS) -o $@ $<

.PHONY: clean
clean:
	rm -f $(OBJS) $(TARGET)
