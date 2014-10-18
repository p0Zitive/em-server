from twisted.web import server, resource

class MainHandler(resource.Resource):
isLeaf = True
def render_GET(self, request):
value = request.args.get(‘value’, [''])[0]
request.setHeader(‘Content-Type’, ‘text/xml’)
if not value:
return ‘no value specified’
else:
return ‘%s’ % value

if __name__ == ‘__main__’:
from twisted.internet import epollreactor
epollreactor.install()
from twisted.internet import reactor

root = MainHandler()
factory = server.Site(root)
reactor.listenTCP(8080, factory)
reactor.run()
