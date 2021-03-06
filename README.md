# vim-config

备份VIM配置

直接运行install.sh安装

## go1.10以上补全问题

2019-03-31

试用deoplete和deoplete-go，响应有点延迟，但是好在于能提供几乎所有的补全（但是针对有成员函数补全还是没有vim-go和YCM这么完整）
先暂时放弃，先使用<c-x><c-o>手动触发补补全，再想想办法解决YCM使用gocode只支持pkg的问题

---
2019/03/17

最好解决办法是只要改了一个包，就运行一次`go install -i [package]`

---

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
