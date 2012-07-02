" widget   - template - spec
" page     - template - spec
" layout   - template - spec
" resource            - spec
" partial

let s:joosyPath     = 'app/assets/javascripts/app/'
let s:joosySpecPath = 'spec/javascripts/'

let s:widget = {
      \'typeName':            'widget',
      \'detectionRegex':      '.*/\(templates/\)\?widgets.*',
      \'nameExtractionRegex': '.*widgets/\zs\w\+\ze.',
      \'templatePath' :       'widgets/',
      \'templateSuffix':      '',
      \'specPath':            'widgets/',
      \'scriptPath':          'widgets/',
      \'scriptSuffix':        ''
      \}

let s:page = {
      \'typeName':            'page',
      \'detectionRegex':      '.*/\(templates/\)\?pages.*',
      \'nameExtractionRegex': '.*pages/\zs\w\+/\w\+\ze\.',
      \'templatePath' :       'pages/',
      \'templateSuffix':      '',
      \'specPath':            'pages/',
      \'scriptPath':          'pages/',
      \'scriptSuffix':        ''
      \}

let s:layout = {
      \'typeName':            'layout',
      \'detectionRegex':      '.*/\(templates/\)\?layouts.*',
      \'nameExtractionRegex': '.*layouts/\zs\w\+\ze_layout',
      \'templatePath' :       'layouts/',
      \'templateSuffix':      '_layout',
      \'specPath':            'layouts/',
      \'scriptPath':          'layouts/',
      \'scriptSuffix':        '_layout'
      \}

let s:resource = {
      \'typeName':            'resource',
      \'detectionRegex':      '.*/resources.*',
      \'nameExtractionRegex': '.*/resources/\zs\w\+\ze\.',
      \'templatePath' :       '',
      \'templateSuffix':      '',
      \'specPath':            'resources/',
      \'scriptPath':          'resources/',
      \'scriptSuffix':        ''
      \}

let s:unknown = { 'typeName': 'unknown' }

let s:types = [ s:page, s:widget, s:layout, s:resource ]

function! JoosyJumpToTemplate()
  call JoosyJumpTo(s:TemplatePath(s:CreateFrom(expand('%'))))
endfunction

function! JoosyJumpToScript()
  call JoosyJumpTo(s:ScriptPath(s:CreateFrom(expand('%'))))
endfunction

function! JoosyJumpToSpec()
  call JoosyJumpTo(s:SpecPath(s:CreateFrom(expand('%'))))
endfunction

function! JoosyJumpTo(path)
  call feedkeys(":e " . a:path)
endfunction

function! s:New(type, name)
  let s:object = copy(a:type)
  let s:object.name = a:name
  return s:object
endfunction

function! s:CreateFrom(filename)
  for s:type in s:types
    if a:filename =~ s:type.detectionRegex
      let s:nameRegex = s:type.nameExtractionRegex
      let s:name = matchstr(a:filename, s:nameRegex)
      return s:New(s:type, s:name)
    endif
  endfor
  return s:New(s:unknown, 'unknown')
endfunction

function! s:TemplatePath(object)
  if a:object.templatePath != ''
    return s:joosyPath . 'templates/' . a:object.templatePath . a:object.name . a:object.templateSuffix . '.jst.hamlc'
  endif
  return ''
endfunction

function! s:SpecPath(object)
  if a:object.specPath != ''
    return s:joosySpecPath . a:object.specPath  . a:object.name . '_spec.js.coffee'
  endif
  return ''
endfunction

function! s:ScriptPath(object)
  if a:object.scriptPath != ''
    return s:joosyPath . a:object.scriptPath . a:object.name . a:object.scriptSuffix . '.js.coffee'
  endif
  return ''
endfunction

map _jt :call JoosyJumpToTemplate()<CR>
map _jj :call JoosyJumpToScript()<CR>
map _js :call JoosyJumpToSpec()<CR>



function! s:AssertEqual(x, y)
  if type(a:x) != type(a:y) || a:x != a:y
    echo string(a:x) . ' is not equal ' . string(a:y)
  endif
endfunction

function! s:TestCreateFrom(filename, expectedTypeName, expectedName)
  let s:object = s:CreateFrom(a:filename)
  call s:AssertEqual(s:object.typeName, a:expectedTypeName)
  call s:AssertEqual(s:object.name, a:expectedName)
endfunction

call s:TestCreateFrom('app/assets/javascripts/app/widgets/current_user.js.coffee',
      \'widget', 'current_user')

call s:TestCreateFrom('app/assets/javascripts/app/templates/widgets/current_user.jst.hamlc',
      \'widget', 'current_user')

call s:TestCreateFrom('spec/javascripts/widgets/current_user_spec.coffee',
      \'widget', 'current_user')

call s:TestCreateFrom('app/assets/javascripts/app/pages/quote_collections/new.js.coffee',
      \'page', 'quote_collections/new')

call s:TestCreateFrom('app/assets/javascripts/app/templates/pages/quote_collections/new.jst.hamlc',
      \'page', 'quote_collections/new')

call s:TestCreateFrom('app/assets/javascripts/app/layouts/application_layout.js.coffee',
      \'layout', 'application')

call s:TestCreateFrom('app/assets/javascripts/app/templates/layouts/application_layout.jst.hamlc',
      \'layout', 'application')

call s:TestCreateFrom('app/assets/javascripts/app/resources/quote_collection.js.coffee',
      \'resource', 'quote_collection')

call s:TestCreateFrom('wrong/path', 'unknown', 'unknown')

function! s:TestTemplatePath(name, type, expectedPath)
  let s:object = s:New(a:type, a:name)
  call s:AssertEqual(s:TemplatePath(s:object), a:expectedPath)
endfunction

call s:TestTemplatePath('current_user', s:widget,
      \'app/assets/javascripts/app/templates/widgets/current_user.jst.hamlc')

call s:TestTemplatePath('quote_collections/new', s:page,
      \'app/assets/javascripts/app/templates/pages/quote_collections/new.jst.hamlc')
  
call s:TestTemplatePath('application', s:layout,
      \'app/assets/javascripts/app/templates/layouts/application_layout.jst.hamlc')

call s:TestTemplatePath('quote_collection', s:resource, '')

function! s:TestSpecPath(name, type, expectedPath)
  let s:object = s:New(a:type, a:name)
  call s:AssertEqual(s:SpecPath(s:object), a:expectedPath)
endfunction

call s:TestSpecPath('current_user', s:widget,
      \'spec/javascripts/widgets/current_user_spec.js.coffee')

call s:TestSpecPath('quote_collections/new', s:page,
      \'spec/javascripts/pages/quote_collections/new_spec.js.coffee')

call s:TestSpecPath('application', s:layout,
      \'spec/javascripts/layouts/application_spec.js.coffee')

call s:TestSpecPath('quote_collection', s:resource,
      \'spec/javascripts/resources/quote_collection_spec.js.coffee')

function! s:TestScriptPath(name, type, expectedPath)
  let s:object = s:New(a:type, a:name)
  call s:AssertEqual(s:ScriptPath(s:object), a:expectedPath)
endfunction

call s:TestScriptPath('current_user', s:widget,
      \'app/assets/javascripts/app/widgets/current_user.js.coffee')

call s:TestScriptPath('quote_collections/new', s:page,
      \'app/assets/javascripts/app/pages/quote_collections/new.js.coffee')

call s:TestScriptPath('application', s:layout,
      \'app/assets/javascripts/app/layouts/application_layout.js.coffee')

call s:TestScriptPath('quote_collection', s:resource,
      \'app/assets/javascripts/app/resources/quote_collection.js.coffee')
