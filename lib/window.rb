class Window
  include Gl, Glu, Glut

  attr_reader :controller

  def initialize(controller)
    @controller = controller
  end

  def views
    @views ||= []
  end

  def display
    controller.apply
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    glLoadIdentity
    views.each do |view|
      view.draw!
    end
    glutSwapBuffers
  end

  def timer(value)
    glutPostRedisplay
    start_timer
  end

  def start_timer
    glutTimerFunc 33, method(:timer).to_proc, nil
  end

  def start
    glutInit
    glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_ALPHA | GLUT_DEPTH)

    glutInitWindowSize(500, 500)
    glutCreateWindow("Hoi")
    glClearColor(0,0,0,0)
    glClearDepth(1.0)
    glDepthFunc(GL_LESS)
    glEnable(GL_DEPTH_TEST)
    glShadeModel(GL_SMOOTH)
    glEnable(GL_LIGHTING)
    glEnable(GL_LIGHT0)
    glEnable(GL_COLOR_MATERIAL)

    glMatrixMode(GL_PROJECTION)
    glLoadIdentity

    gluPerspective(45, 1, 0.1, 10000) #aspect ratio
    glMatrixMode(GL_MODELVIEW)

    start_timer
    glutDisplayFunc method(:display).to_proc

    glutKeyboardFunc   controller.method(:key_press).to_proc
    glutSpecialFunc    controller.method(:special_key_press).to_proc
    glutSpecialUpFunc  controller.method(:special_key_up).to_proc
    glutKeyboardUpFunc controller.method(:key_up).to_proc

    glutMainLoop
  end

end
