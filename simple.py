from werkzeug.wrappers import Request, Response
import sys

hostname=str(sys.argv[1])
port=int(sys.argv[2])

@Request.application
def application(request):
    return Response('Hello World22!')

if __name__ == '__main__':
    from werkzeug.serving import run_simple
    run_simple(hostname,port, application)
