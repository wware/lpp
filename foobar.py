class Foo(object):
    def foo(self):
        print "nope"

class Bar(object):
    def foo(self):
        print "nope"

class Foobar(object):
    def foo(self):
        x = 3
        print "yup"
        print x
