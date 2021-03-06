let s:EmptyFn = function('empty')


""
" Checks that {condition} is nonzero. If not, throws Failure with [message],
" formatted with [args...].
" @default message="No message given."
" @throws Failure if {condition} is zero.
" @throws WrongType if {condition} is not a number.
function! ensure#IsTrue(condition, ...) abort
  call ensure#IsNumber(a:condition)
  if a:condition
    return
  endif
  let l:args = empty(a:000) ? ['No message given.'] : a:000
  throw call('error#Failure', l:args)
endfunction


""
" Checks that {condition} is zero. If not, throws Failure with [message],
" formatted with [args...].
" @default message="No message given."
" @throws Failure if {condition} is nonzero.
" @throws WrongType if {condition} is not a number.
function! ensure#IsFalse(condition, ...) abort
  let l:args = [!ensure#IsNumber(a:condition)] + a:000
  return call('ensure#IsTrue', l:args)
endfunction


""
" Ensures that {value} is equal to {reference}. Returns {value} for convenience.
" Equality is checked using @function(value#IsEqual). Note that {value}
" and {reference} MUST share a type: 1.0 does not equal 1! This is consistent
" with the behavior of instant() and count() rather than with the behavior of
" the '==' operator.
" @throws WrongType if {value} is not the same type as {reference}.
" @throws BadValue if {value} does not equal {reference}.
function! ensure#IsEqual(Value, Reference) abort
  if value#IsEqual(a:Value, a:Reference)
    return a:Value
  endif
  throw error#Message(
      \ type(a:Value) == type(a:Reference) ? 'BadValue' : 'WrongType',
      \ 'Expected %s. Got %s.',
      \ string(a:Value),
      \ string(a:Reference))
endfunction


""
" @usage value values
" Ensures that {value} is in {values}.
" Returns {value} for convenience.
" @throws BadValue if {value} is not contained in {values}
" @throws BadValue if {values} is not a list.
function! ensure#IsIn(Value, values) abort
  if value#IsIn(a:Value, a:values)
    return a:Value
  endif
  let l:msg = 'Expected one of %s. Got %s.'
  let l:expected = join(map(copy(a:values), 'string(v:val)'), ' or ')
  throw error#BadValue(l:msg, l:expected, string(a:Value))
endfunction


""
" @usage value predicate
" Ensures that {value} passes {predicate}. {predicate} must be something
" callable (see |function#Call|), and must take a single argument. It
" should return 1 or 0. On a 1, {value} is returned. On a 0, a BadValue error is
" thrown. Returns {value} for convenience.
" @throws BadValue if {value} does not pass {predicate}.
" @throws WrongType if {predicate} is not callable.
function! ensure#Passes(Value, P) abort
  call ensure#IsCallable(a:P)
  if function#Apply(a:P, a:Value)
    return a:Value
  endif
  throw error#BadValue('%s failed to pass predicate.', string(a:Value))
endfunction


""
" Ensures that {value} has the same type as {reference}.
" Returns {value} for convenience.
" @throws WrongType
function! ensure#TypeMatches(Value, reference) abort
  if type(a:Value) == type(a:reference)
    return a:Value
  endif
  throw error#WrongType(
      \ 'Expected a %s. Got a %s.',
      \ value#TypeName(a:reference),
      \ value#TypeName(a:Value))
endfunction


""
" Ensures that {value} has the same type as one of the elements in {values}.
" Returns {value} for convenience
" @throws WrongType
function! ensure#TypeMatchesOneOf(Value, values) abort
  if index(map(copy(a:values), 'type(v:val)'), type(a:Value)) >= 0
    return a:Value
  endif
  throw error#WrongType(
      \ 'Expected a %s. Got a %s.',
      \ join(map(copy(a:values), 'value#TypeName(v:val)'), ' or '),
      \ value#TypeName(a:Value))
endfunction


""
" Ensures that {value} is 0 or 1, returns it for convenience.
" @throws BadValue if {value} is a number but not 0 or 1.
" @throws WrongType if {value} is not a number.
function! ensure#IsBool(Value) abort
  return ensure#IsIn(ensure#IsNumber(a:Value), [0, 1])
endfunction

""
" Ensures that {value} is a number, returns it for convenience.
" @throws WrongType
function! ensure#IsNumber(Value) abort
  return ensure#TypeMatches(a:Value, 0)
endfunction

""
" Ensures that {value} is a string, returns it for convenience.
" @throws WrongType
function! ensure#IsString(Value) abort
  return ensure#TypeMatches(a:Value, '')
endfunction


""
" Ensures that {value} is a funcref, returns it for convenience.
" @throws WrongType
function! ensure#IsFuncref(Value) abort
  return ensure#TypeMatches(a:Value, s:EmptyFn)
endfunction

""
" Ensures that {value} is a list, returns it for convenience.
" @throws WrongType
function! ensure#IsList(Value) abort
  return ensure#TypeMatches(a:Value, [])
endfunction

""
" Ensures that {value} is a dictionary, returns it for convenience.
" @throws WrongType
function! ensure#IsDict(Value) abort
  return ensure#TypeMatches(a:Value, {})
endfunction


""
" Ensures that {value} is a float, returns it for convenience.
" @throws WrongType
function! ensure#IsFloat(Value) abort
  return ensure#TypeMatches(a:Value, 0.0)
endfunction


""
" Ensures that {value} is numeric (float or number), returns it for convenience.
" @throws WrongType
function! ensure#IsNumeric(Value) abort
  return ensure#TypeMatchesOneOf(a:Value, [0, 0.0])
endfunction


""
" Ensures that {value} is a collection (list or dict), returns it for
" convenience.
" @throws WrongType
function! ensure#IsCollection(Value) abort
  return ensure#TypeMatchesOneOf(a:Value, [[], {}])
endfunction


""
" Ensures that {value} is callable (string or funcref). Returns it for
" convenience.  This DOES NOT assert that the function denoted by {value}
" actually exists. It merely ensures that {value} is the correct TYPE for
" @function(function#Call).
" @throws WrongType if {value} is not a string, funcref, nor dict.
" @throws BadValue if {value} is a dict but does not appear to be a funcdict.
function! ensure#IsCallable(Value) abort
  call ensure#TypeMatchesOneOf(a:Value, ['', {}, s:EmptyFn])
  if value#TypeMatchesOneOf(a:Value, ['', s:EmptyFn])
    return a:Value
  endif
  if function#IsWellFormedDict(a:Value)
    return a:Value
  endif
  let l:msg = 'Dictionary with keys %s is not a maktaba function.'
  throw error#BadValue(l:msg, string(keys(a:Value)))
endfunction


""
" Ensures that {value} is a maktaba enum object, returns it for convenience.
" @throws WrongType if {value} is not a dictionary.
" @throws BadValue if {value} does not appear to be a maktaba enum object.
function! ensure#IsEnum(Value) abort
  call ensure#IsDict(a:Value)
  if enum#IsValid(a:Value)
    return a:Value
  endif
  let l:msg = 'Dictionary with keys %s is not a maktaba enum.'
  throw error#BadValue(l:msg, string(keys(a:Value)))
endfunction


""
" Ensures that {value} is a string matching {regex}. Case sensitive matching is
" used. Returns {value} for convenience.
" @throws WrongType
" @throws BadValue
function! ensure#Matches(Value, regex) abort
  call ensure#IsString(a:Value)
  call ensure#IsString(a:regex)
  if a:Value !~# a:regex
    let l:msg = '%s does not match %s.'
    throw error#BadValue(l:msg, string(a:Value), string(a:regex))
  endif
endfunction


""
" Ensures {path} exists on the filesystem. Returns {path} for convenience.
" @throws NotFound otherwise.
" @throws WrongType if {path} is not a string.
function! ensure#PathExists(path) abort
  call ensure#IsString(a:path)
  if path#Exists(a:path)
    return a:path
  endif
  throw error#NotFound('File or directory %s.', a:path)
endfunction


""
" Ensures {path} is an existing directory. Returns {path} for convenience.
" @throws NotFound if {path} does not exist.
" @throws BadValue if {path} is a file.
" @throws WrongType if {path} is not a string.
function! ensure#IsDirectory(path) abort
  call ensure#IsString(a:path)
  if path#Exists(a:path)
    if isdirectory(a:path)
      return a:path
    endif
    throw error#BadValue('%s is a file.', a:path)
  endif
  throw error#NotFound('Directory %s not found.', a:path)
endfunction


""
" Ensures {path} is an existing file. Returns {path} for convenience.
" @throws NotFound if {path} does not exist.
" @throws BadValue if {path} is a directory.
" @throws WrongType if {path} is not a string.
function! ensure#IsFile(path) abort
  call ensure#IsString(a:path)
  if path#Exists(a:path)
    if isdirectory(a:path)
      throw error#BadValue('%s is a directory.', a:path)
    endif
    return a:path
  endif
  throw error#NotFound('File %s not found.', a:path)
endfunction


""
" Ensures {path} is a readable file. Returns {path} for convenience.
" @throws NotFound if {path} does not exist.
" @throws BadValue if {path} is a directory.
" @throws NotAuthorized if {path} cannot be read.
" @throws WrongType if {path} is not a string.
function! ensure#FileReadable(path) abort
  call ensure#IsFile(a:path)
  if filereadable(a:path)
    return a:path
  endif
  throw error#NotAuthorized('%s is not readable.', a:path)
endfunction


""
" Ensures {path} is a writable file. Returns {path} for convenience.
" @throws NotFound if {path} does not exist.
" @throws BadValue if {path} is a directory.
" @throws NotAuthorized if {path} cannot be written.
" @throws WrongType if {path} is not a string.
function! ensure#FileWritable(path) abort
  call ensure#IsFile(a:path)
  if filewritable(a:path)
    return a:path
  endif
  throw error#NotAuthorized('%s is not writable.', a:path)
endfunction


""
" Ensures {path} is an absolute path. Returns {path} for convenience.
" @throws BadValue if {path} is not absolute.
" @throws WrongType if {path} is not a string.
function! ensure#IsAbsolutePath(path) abort
  call ensure#IsString(a:path)
  if path#IsAbsolute(a:path)
    return a:path
  endif
  throw error#BadValue('%s is not an absolute path.', a:path)
endfunction


""
" Ensures {path} is a relative path. Returns {path} for convenience.
" @throws BadValue if {path} is not relative.
" @throws WrongType if {path} is not a string.
function! ensure#IsRelativePath(path) abort
  call ensure#IsString(a:path)
  if path#IsRelative(a:path)
    return a:path
  endif
  throw error#BadValue('%s is not a relative path.', a:path)
endfunction
