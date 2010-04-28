module Position
  protected

  def last_indent
    case self
    when Ruby::Block, Ruby::Class
      last_position(get_elements)                           
    else
      puts "unknown: #{obj.class}"
    end
  end

  def last_position(elements) 
    last_element = elements.last
    return position.col 
    return position.col if simple_pos?(last_element)
    return last_element.identifier.position.col if elements && elements.size > 0
    inside_indent
  end

  def simple_pos?(elem)       
    [Ruby::Token, Ruby::Variable].include?(elem.class)
  end

  def first_indent
    case self
    when Ruby::Block, Ruby::Class
      first_position(get_elements)                           
    else
      puts "unknown: #{obj.class}"
    end
  end

  def first_position(elements) 
    first_element = elements.first
    return position.col if simple_pos?(first_element)
    return first_element.identifier.position.col if elements && elements.size > 0
    inside_indent
  end
end