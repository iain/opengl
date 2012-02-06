class Window
  include Gl, Glu, Glut

  attr_reader :controller, :textures
  attr_accessor :width, :height, :title

  def initialize(controller)
    @controller = controller
    @textures = Textures.new
    controller.window = self
    default_values!
  end

  def default_values!
    self.width = 700
    self.height = 450
    self.title = "Ruby OpenGL"
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
    #glEnable( GL_CULL_FACE )

    glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)

    glEnable(GL_COLOR_MATERIAL)

    #lighting and lighting position _Abstraction would be nice...
    glEnable(GL_LIGHTING)
    glEnable(GL_LIGHT0)
    glEnable(GL_LIGHT1)
    glLightfv(GL_LIGHT0, GL_DIFFUSE, [1, 1, 1])
    glLightfv(GL_LIGHT1, GL_AMBIENT, [1, 1, 1])
    glLightfv(GL_LIGHT0, GL_POSITION, [0, 2, 0, 0])



    glMatrixMode(GL_PROJECTION)
    glLoadIdentity

    gluPerspective(45, 1, 0.1, 10000) #aspect ratio
    glMatrixMode(GL_MODELVIEW)

    textures.load_all

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
