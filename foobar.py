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

def some_other_thing():    #+otherstuff
    print "abc"
    print "def"
    print "ghi"      #-otherstuff
