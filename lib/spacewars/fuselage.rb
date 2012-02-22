class Fuselage < Walker::View

  def draw
    mult_matrix(@model.matrix)
    # glMaterial(GL_FRONT_AND_BACK, GL_DIFFUSE, [0.8, 0.8, 0.8, 1.0])
    if @model.in_warp && @model.velocity.magnitude
      glScale(1, 1, @model.velocity.magnitude/@model.warp_speed + 1)
    end
    scale(1e4)

    glMaterial(GL_FRONT_AND_BACK, GL_EMISSION, [0.0, 0.0, 0.0, 0.0])

    glEnable(GL_COLOR_MATERIAL)
    draw_middle
    draw_engine( 4,1, 6)
    draw_engine(-4,1, 6)
    draw_engine_connections
    draw_dish_connection

    draw_dish

    glDisable(GL_COLOR_MATERIAL)
  end

  def draw_dish
    #bottom dish
    glColor(0.5, 0.5, 0.5)
    glBegin(GL_TRIANGLE_FAN)
    glVertex(0, -0.8, 0)
    size = 5
    37.times do |i|
      deg = i * 2 * Math::PI / 36
      glColor(0.3, 0.3, 0.3)
      glVertex(Math.cos(deg) * size, 0, Math.sin(deg) * size)
    end
    glEnd

    #dish width
    glBegin(GL_QUADS)
    step = 2 * Math::PI / 36
    36.times do |i|
      deg = i * step
      glVertex(Math.cos(deg) * size, 0, Math.sin(deg) * size)
      glVertex(Math.cos(deg) * size, 1, Math.sin(deg) * size)
      glVertex(Math.cos(deg + step) * size, 1, Math.sin(deg + step) * size)
      glVertex(Math.cos(deg + step) * size, 0, Math.sin(deg + step) * size)
    end
    glEnd

    #top dish
    glColor(0.5, 0.5, 0.5)
    glBegin(GL_TRIANGLE_FAN)
    glVertex(0, 1, 0)
    37.times do |i|
      deg = i * 2 * Math::PI / 36
      glVertex(Math.cos(deg) * size, 1, Math.sin(deg) * size)
    end
    glEnd

    #second row
    glBegin(GL_QUADS)
    step = 2 * Math::PI / 36
    size = 2.5
    inner_size = 1.1
    37.times do |i|
      deg = i * step
      glColor(0.4, 0.4, 0.4)
      glVertex(Math.cos(deg)        * size       ,1  , Math.sin(deg       ) * size)
      glVertex(Math.cos(deg + step) * size       ,1  , Math.sin(deg + step) * size)
      glColor(0.3, 0.3, 0.3)
      glVertex(Math.cos(deg + step) * inner_size ,1.5, Math.sin(deg + step) * inner_size)
      glVertex(Math.cos(deg       ) * inner_size ,1.5, Math.sin(deg       ) * inner_size)
    end
    glEnd

    #little bubble on top
    glTranslate(0, 0.5, 0)
    glutSolidSphere(1.5,36,36)

  end

  def draw_middle

    #tube
    step = 2 * Math::PI / 36
    size = 0.7
    y = -3
    z =  1
    glBegin(GL_QUADS)
    glColor(0.3, 0.3, 0.3)
    37.times do |i|
      deg = i * step
      glVertex(Math.cos(deg) * size       , Math.sin(deg) * size + y       , z)
      glVertex(Math.cos(deg) * size       , Math.sin(deg) * size + y       , 7 + z)
      glVertex(Math.cos(deg + step) * size, Math.sin(deg + step) * size + y, 7 + z)
      glVertex(Math.cos(deg + step) * size, Math.sin(deg + step) * size + y, z)
    end
    glEnd

    #circle at end

    glBegin(GL_TRIANGLE_FAN)
    glColor(0,0,0)
    glVertex(0, y, 7 + z)
    37.times do |i|
      deg = i * step
      glVertex(Math.cos(deg) * size, Math.sin(deg) * size + y, 7 + z)
    end
    glEnd

    #circle at front

    glBegin(GL_TRIANGLE_FAN)
    glColor(0.5,0.5,0.5)
    glVertex(0, y, 7 + z)
    37.times do |i|
      deg = i * step
      glVertex(Math.cos(deg) * size, Math.sin(deg) * size + y, z)
    end
    glEnd
  end

  def draw_engine(x, y, z)
    step = 2 * Math::PI / 36
    size = 0.5
    glBegin(GL_QUADS)
    glColor(0.3, 0.3, 0.3)
    37.times do |i|
      deg = i * step
      glVertex(Math.cos(deg) * size + x, Math.sin(deg) * size + y, z)
      glVertex(Math.cos(deg) * size + x, Math.sin(deg) * size + y, 5 + z)
      glVertex(Math.cos(deg + step) * size + x, Math.sin(deg + step) * size + y, 5 + z)
      glVertex(Math.cos(deg + step) * size + x, Math.sin(deg + step) * size + y, z)
    end
    glEnd

    #red front circle
    glBegin(GL_TRIANGLE_FAN)
    glColor(0.8,0.4,0.4)
    glVertex(x, y, z)
    37.times do |i|
      deg = i * step
      glVertex(Math.cos(deg) * size + x, Math.sin(deg) * size + y, z)
    end
    glEnd

    #black end circle
    glBegin(GL_TRIANGLE_FAN)
    glColor(0,0,0)
    glVertex(x, y, z)
    z += 5
    37.times do |i|
      deg = i * step
      glVertex(Math.cos(deg) * size + x, Math.sin(deg) * size + y, z)
    end
    glEnd
  end

  def draw_engine_connections
    #tube
    x = 0
    y = -3
    z = 7

    step = 2 * Math::PI / 36
    size = 0.2
    glBegin(GL_QUADS)
    glColor(0.2,0.2,0.2)
    37.times do |i|
      deg = i * step
      glVertex(Math.cos(deg)        * size + x    , y    , Math.sin(deg)        * size + z)
      glVertex(Math.cos(deg)        * size + x + 4, y + 4, Math.sin(deg)        * size + z)
      glVertex(Math.cos(deg + step) * size + x + 4, y + 4, Math.sin(deg + step) * size + z)
      glVertex(Math.cos(deg + step) * size + x    , y    , Math.sin(deg + step) * size + z)
    end

    37.times do |i|
      deg = i * step
      glVertex(Math.cos(deg)        * size + x    , y    , Math.sin(deg)        * size + z)
      glVertex(Math.cos(deg)        * size + x - 4, y + 4, Math.sin(deg)        * size + z)
      glVertex(Math.cos(deg + step) * size + x - 4, y + 4, Math.sin(deg + step) * size + z)
      glVertex(Math.cos(deg + step) * size + x    , y    , Math.sin(deg + step) * size + z)
    end

    glEnd
  end

  def draw_dish_connection
    x = 0
    y = -3
    z = 3

    step = 2 * Math::PI / 36
    size = 0.5
    glBegin(GL_QUADS)
    glColor(0.2,0.2,0.2)
    37.times do |i|
      deg = i * step
      glVertex(Math.cos(deg)        * size + x    , y    , Math.sin(deg)        * size * 2 + z)
      glVertex(Math.cos(deg)        * size + x    , y + 4, Math.sin(deg)        * size * 2 - 2 + z)
      glVertex(Math.cos(deg + step) * size + x    , y + 4, Math.sin(deg + step) * size * 2 - 2 + z)
      glVertex(Math.cos(deg + step) * size + x    , y    , Math.sin(deg + step) * size * 2 + z)
    end
    glEnd
  end
end
