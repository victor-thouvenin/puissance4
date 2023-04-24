require 'socket'

@online = false
if ARGV[0] == "--online"
    if ARGV.length < 2
        puts "you must enter the game port if you to play online"
        return 1
    end
    @online = true
end
if @online
    socket = TCPServer.new (ARGV[1])
    puts "waiting for connection"
    @client = socket.accept
end
@tab = []
@player = 0
7.times{|i| @tab[i] = []; @tab[i][6] = nil}
def print_tab
    grid = ""
    7.times{|i| grid << " #{i+1}"}; grid << "\n"
    7.times.reverse_each{|i|
        7.times{|j|
            grid << "|#{@tab[j][i] == nil ? ' ' : @tab[j][i]}"
        }
        grid << "|\n"
    }
    7.times{grid << "--"}; grid << "-\n\n"
    print grid
    if @online
        begin
            @client.print grid
        rescue
            raise "error"
        end
    end
end
def play()
    if @player == 0 || !@online
        if !@online
            puts "player #{@player+1}'s turn"
        else
            puts "your turn"
            @client.print "opponent playing\n\n"
        end
        ind = $stdin.gets.chomp.to_i() -1
        if ind < 0 || ind > 6
            puts "invalid input"
            return false
        end
    else
        begin
            @client.puts "your turn"
        rescue
            raise "error"
        end
        print "opponent playing\n\n"
        ind = @client.gets.chomp.to_i() -1
        if ind < 0 || ind > 6
            @client.puts "invalid input"
            return false
        end
    end
    @tab[ind].each_with_index { |v,i|
    if v == nil
        @tab[ind][i] = @player == 0 ? 'O' : '@'
        return true
    elsif i == 6
        if @player == 0  || !@online
            print "that column is already full\n\n"
        else
            @client.print "that column is already full\n\n"
        end
        return false
    end
    }
    return true
end
def check_win
    @tab.each_with_index{|t,i|
        t.each_with_index{|v, j|
            line = i < 4 && v == @tab[i+1][j] && v == @tab[i+2][j] && v == @tab[i+3][j]
            column = j < 4 && v == t[j+1] && v == t[j+2] && v == t[j+3]
            diagonal = i < 4 && j < 4 && v == @tab[i+1][j+1] && v == @tab[i+2][j+2] && v == @tab[i+3][j+3]
            diagonal2 = i < 4 && j > 2 && v == @tab[i+1][j-1] && v == @tab[i+2][j-2] && v == @tab[i+3][j-3]
            if v != nil && (line || column || diagonal || diagonal2)
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
print_tab
loop do
    begin
        if !play
            next
        end
        print_tab
    rescue
        puts "an error has occured"
        break
    end
    if check_win
        print_tab
        if !online
            puts "player #{@player+1} won"
        elsif @player == 0
            puts "you win ! perfect"; @client.puts "you lose. huuuuuu"
        else
            puts "you lose. huuuuuu"; @client.puts "you win ! perfect"
        end
        break
    elsif check_tie
        print_tab
        puts "tie"
        if @online
            @client.puts "tie"
        end
        break
    end
    @player = (@player + 1) % 2
end
if @online
    @client.close
end
