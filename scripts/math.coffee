# Commands:
#   вась посчитай <выражение>

module.exports = (robot) ->
    robot.respond /посчитай (.*)/i, (msg) ->
        req = msg.http "https://www.google.com/ig/calculator"
        req.query hl: "en", q: msg.match[1]
        req.headers
            "Accept-Language": "en-us,en;q=0.5",
            "Accept-Charset": "utf-8",
            "User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:2.0.1) Gecko/20100101 Firefox/4.0.1"
        req.get() (err, res, body) ->
            # Response includes non-string keys, so we can't use JSON.parse here.
            json = eval("(#{body})")
            msg.send json.rhs or "не могу посчитать"
