@tab = []
@player = 0
7.times{|i| @tab[i] = []; @tab[i][6] = nil}
def print_tab
    7.times{|i| print (" #{i+1}")}; puts ""
    7.times.reverse_each{|i| 7.times{|j| print "|#{@tab[j][i] == nil ? ' ' : @tab[j][i]}"}; puts "|"}
    7.times{print "--"}; puts "-\n\n"
end
def play()
    ind = gets.chomp.to_i() -1
    if ind < 0 || ind > 6
        puts "out of range"
        return false
    end
    @tab[ind].each_with_index { |v,i|
    if v == nil
        @tab[ind][i] = @player == 0 ? 'O' : '@'
        return true
    elsif i == 6
        puts "that column is full\n\n"
        return false
    end
    }
end
def check_win
    @tab.each_with_index{|t,i|
        t.each_with_index{|v, j|
            line = i < 4 && v == @tab[i+1][j] && v == @tab[i+2][j] && v == @tab[i+3][j]
            column = j < 4 && v == t[j+1] && v == t[j+2] && v == t[j+3]
            diagonal = i < 4 && j < 4 && v == @tab[i+1][j+1] && v == @tab[i+2][j+2] && v == @tab[i+3][j+3]
            if v != nil && (line || column || diagonal)
                return true
            end
        }
    }
    return false
end
def check_tie
    @tab.each_with_index{|t,i|
        t.each_with_index{|v, j|
            if v == nil
                return false
            end
        }
    }
    return true
end
loop do
    print_tab
    if !play
        next
    end
    if check_win
        print_tab
        puts "player #{@player+1} win"
        break
    elsif check_tie
        print_tab
        puts "tie"
        break
    end
    @player = (@player + 1) % 2
end
