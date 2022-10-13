DEBUG = 0

import lldb
if DEBUG:
  import debugpy

def String( valobj: lldb.SBValue, internal_dict, options ):
  data: lldb.SBValue = valobj.GetChildMemberWithName('data')
  len = valobj.GetChildMemberWithName('count').GetValueAsSigned(0)
  return bytes( data.GetPointeeData(0, len).uint8s ).decode( 'utf-8' )

def Array( valobj: lldb.SBValue, internal_dict, options ):
  return ( "Array(count="
           + str( len( valobj.children ) )
           + ")" )

class ArrayChildrenProvider:
  def __init__( self, valobj: lldb.SBValue, internal_dict) :
    self.val = valobj

  def update(self):
    self.count = self.val.GetChildMemberWithName( 'count' ).GetValueAsSigned()
    self.data: lldb.SBValue = self.val.GetChildMemberWithName('data')
    self.data_type: lldb.SBType = self.data.GetType().GetPointeeType()
    self.data_size = self.data_type.GetByteSize()

    return False

  def has_children(self):
    return True

  def num_children(self):
    return self.count

  def get_child_at_index(self, index):
    return self.data.CreateChildAtOffset( str(index),
                                          self.data_size * index,
                                          self.data_type )

  def get_child_index(self, name):
    return int( name )


def __lldb_init_module( debugger: lldb.SBDebugger, dict ):
  if DEBUG:
    debugpy.listen( 5432 )
    debugpy.wait_for_client()
  debugger.HandleCommand( 'type summary add -F jaitype.String string' )
  debugger.HandleCommand( 'type summary add -F jaitype.Array "[] string"' )
  debugger.HandleCommand(
    'type synthetic add "[] string" -l jaitype.ArrayChildrenProvider' )


