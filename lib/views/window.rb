class Window
  include Gl, Glu, Glut

  attr_reader :controller
  attr_accessor :width, :height, :title, :framerate

  def initialize(controller)
    @controller = controller
    controller.window = self
    default_values!
  end

  def default_values!
    self.framerate = 60
    self.width = 700
    self.height = 450
    self.title = "Ruby OpenGL"
  end

  def views
    @views ||= []
  end

  def display
    controller.fire_events
    redraw
  end

  def redraw
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
    glutTimerFunc 1000 / framerate, method(:timer).to_proc, nil
  end

  def enter_full_screen
    glutFullScreen
  end

  def leave_full_screen
    glutReshapeWindow(width, height)
  end

  def reshape(width, height)
    glViewport 0, 0, width, height
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity
    gluPerspective(45, width / height, 0.1, 1000)
    glMatrixMode(GL_MODELVIEW)
  end

  def start
    glutInit
    glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_ALPHA | GLUT_DEPTH)

    glutInitWindowSize(width, height)
    glutCreateWindow(title)
    glClearColor(0,0,0,0)
    glClearDepth(1.0)
    glDepthFunc(GL_LESS)
    glEnable(GL_DEPTH_TEST)
    glShadeModel(GL_SMOOTH)
    glEnable(GL_LIGHTING)
    glEnable(GL_LIGHT0)
    glEnable(GL_COLOR_MATERIAL)

    start_timer

    glutDisplayFunc method(:display).to_proc
    glutReshapeFunc method(:reshape).to_proc

    glutKeyboardFunc   controller.method(:key_press).to_proc
    glutSpecialFunc    controller.method(:special_key_press).to_proc
    glutSpecialUpFunc  controller.method(:special_key_up).to_proc
    glutKeyboardUpFunc controller.method(:key_up).to_proc

    glutMainLoop
  end

end