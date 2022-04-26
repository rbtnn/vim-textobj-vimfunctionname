
# vim-textobj-vimfunctionname

vim-textobj-vimfunctionname is a Vim plugin to provide text objects (avf and ivf by default) to select a vim function name.

__avf__
```
 " built-in function name
 abs(234)
 <-->

 " Global function name
 GetProp(234)
 <------>

 " script scoped function name
 s:get_prop(234)
 <--------->

 " dict function name
 xxx.yyy.zzz(234)
 <---------->

 " autoload function name
 xxx#yyy#zzz(234, 234)
 <---------->
```

__ivf__
```
 " built-in function name
 abs(234)
 <->

 " Global function name
 GetProp(234)
 <----->

 " script scoped function name
 s:get_prop(234)
 <-------->

 " dict function name
 xxx.yyy.zzz(234)
 <--------->

 " autoload function name
 xxx#yyy#zzz(234, 234)
 <--------->
```

## Installation

This is an example of installation using vim-plug.

```
Plug 'rbtnn/vim-textobj-vimfunctionname'
Plug 'kana/vim-textobj-user'
```

## Requirements

* [kana/vim-textobj-user](https://github.com/kana/vim-textobj-user)

## Configuration
By default this motion is mapped to 'vf'. The key mapping can be overridden by adding a line similar to this to your vimrc:

```
let g:vim_textobj_vimfunctionname_mapping = 'x'
```

## License
Distributed under MIT License. See LICENSE.

