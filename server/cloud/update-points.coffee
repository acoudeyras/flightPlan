'use strict'

Parse.Cloud.job 'updatePoints', (request, status) ->
  Parse.Cloud.useMasterKey()
  query = new Parse.Query 'Point'
  query.each (point) ->
    return point.save()
  .then ->
    status.success 'Migration completed successfully'
  , (error) -> 
    status.error 'Oups' + error