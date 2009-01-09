require 'point'
require 'word'

class WordFinder

  def find_words(matrix, dictionary)
    words = []

    (0...matrix.size).each do | x |
      (0...matrix[x].size).each do | y |
        spider([Point.new(x, y)], matrix, dictionary, words)
      end
    end

    words
  end

  def spider(points, matrix, dictionary, words)
    if points[-1] and points.index(points[-1]) == (points.size - 1)
      word = points.collect { | point | matrix[point.x][point.y].letter }.to_s
      result = dictionary.lookup(word)

      words << Word.new(word, points.clone) if result.was_found

      if result.is_prefix
        spider(points + [above(points[-1], matrix)], matrix, dictionary, words)
        spider(points + [below(points[-1])], matrix, dictionary, words)

        spider(points + [bottom_right(points[-1], matrix)], matrix, dictionary, words)
        spider(points + [top_right(points[-1], matrix)], matrix, dictionary, words)

        spider(points + [bottom_left(points[-1], matrix)], matrix, dictionary, words)
        spider(points + [top_left(points[-1], matrix)], matrix, dictionary, words)
      end
    end
  end

  def top_right(point, matrix)
    if room_to_the_right_of(point, matrix)
      if tall_row?(point, matrix)
        return Point.new(point.x + 1, point.y) if point.y != (matrix[point.x].size - 1)
      else
        return Point.new(point.x + 1, point.y + 1)
      end
    end

    return nil
  end

  def bottom_right(point, matrix)
    if room_to_the_right_of(point, matrix)
      if tall_row?(point, matrix)
        return Point.new(point.x + 1, point.y - 1) if point.y != 0
      else
        return Point.new(point.x + 1, point.y)
      end
    end

    return nil
  end

  def top_left(point, matrix)
    if room_to_the_left_of(point)
      if tall_row?(point, matrix)
        return Point.new(point.x - 1, point.y) if point.y != (matrix[point.x].size - 1)
      else
        return Point.new(point.x - 1, point.y + 1)
      end
    end

    return nil
  end

  def bottom_left(point, matrix)
    if room_to_the_left_of(point)
      if tall_row?(point, matrix)
        return Point.new(point.x - 1, point.y - 1) if point.y != 0
      else
        return Point.new(point.x - 1, point.y)
      end
    end

    return nil
  end

  def above(point, matrix)
    return point.y + 1 < matrix[point.x].size ? Point.new(point.x, point.y + 1) : nil
  end

  def below(point)
    return point.y > 0 ? Point.new(point.x, point.y - 1) : nil
  end

  def room_to_the_left_of(point)
    point.x - 1 >= 0
  end

  def room_to_the_right_of(point, matrix)
    point.x + 1 < matrix.size
  end

  def tall_row?(point, matrix)
    shift = point.x + 1 < matrix.size ? 1 : -1
    return matrix[point.x].size > matrix[point.x + shift].size
  end

end
