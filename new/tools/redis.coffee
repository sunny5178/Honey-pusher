
redis = require "redis"
querystring = require 'querystring'

r = redis.createClient()
r.on "error", (_e)->
    console.log "redis error: #{ _e }"

r.flushall()


module.exports =
    pub: (_data)->
        data = querystring.parse _data
        if data.project
            ###
            Get room name
            ###
            if data.type is 'subscribe'
                room = "#{data.project}:channel:#{data.channel}"
            else
                room = if data.to then "#{ data.project}:#{ data.to }" else data.project
            console.log room
            data.room = room
        #io.sockets.in(room).emit data.type, data
        console.log data
        r.publish "honey:pusher", JSON.stringify data
