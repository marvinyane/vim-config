# vim-config

备份VIM配置

直接运行install.sh安装

## 快捷键

|模式|快捷键|功能|
|---|---|---|
|normal|ctrl+]|跳转到定义|
|normal|ctrl+t|跳转出栈|
|normal|ctrl+i|前进一步|
|normal|ctrl+o|后退一步|
|normal|ctrl+w,v|垂直分屏|
|normal|ctrl+w,s|水平分屏|
|normal|ctrl+h|激活左屏|
|normal|ctrl+j|激活下屏|
|normal|ctrl+k|激活上屏|
|normal|ctrl+l|激活右屏|
|normal|ctrl+\ |cscope|
|normal|,w|保存文件|
|normal|,,s+[任意一个字段]|快速跳转|
|normal|,a|全局搜索|
|insert|ctrl+e|snipt自生成代码|
|visual|,r|替换|

## go1.10以上补全问题

2019/03/17

最好解决办法是只要改了一个包，就运行一次`go install -i [package]`

===

2019/03/16

go1.10以上的import package不能补全的问题

- 使用`$GOPATH`的项目，需要改一下YCM的文件`.vim/plugged/YouCompleteMe/third_party/ycmd/ycmd/completers/go/go_completer.py`
```
def ComputeCandidatesInner( self, request_data ):
  filename = request_data[ 'filepath' ]
  LOGGER.info( 'Gocode completion request %s', filename )

  contents = utils.ToBytes(
      request_data[ 'file_data' ][ filename ][ 'contents' ] )

  # NOTE: Offsets sent to gocode are byte offsets, so using start_column
  # with contents (a bytes instance) above is correct.
  offset = _ComputeOffset( contents,
                           request_data[ 'line_num' ],
                           request_data[ 'start_column' ] )

  stdoutdata = self._ExecuteCommand( [ self._gocode_binary_path,
                                       '-sock', 'tcp', '-source',
                                       '-addr', self._gocode_host,
                                       '-f=json', 'autocomplete',
                                       filename, str( offset ) ],
                                     contents = contents )
```
