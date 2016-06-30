require 'player'


#Class to enable transpose
class Array
  def safe_transpose
    max_size = self.map(&:size).max
    self.dup.map{|r| r << nil while r.size < max_size; r}.transpose
  end
end


#Main class that handles the game board 

class Board
   def initialize
       @board = Array.new(7){Array.new(6, "z")}
       @counter = 0
       @column=0
       @rowcoordinate=0
   end
   attr_accessor :counter, :column, :board

#Main render function   
   def render
       puts "--------- CONNECT 4 ---------"
       puts "-----------------------------"
       @board.safe_transpose.each do |row|
           row.each do |cell|
               print "|"
               if cell == "z"
                 print("---")
               else
                 print(" #{cell.to_s} ")
               end
           end
       print "|"
       puts
       puts "-----------------------------"
       end
    end
   
#method to add piece. Called on player class under get_cord 
   def add_piece(column,symbol)
       @column=column
       if column_avaliable?
          i=6
          while i >= 0 
            #if column holds value "z", that means it is empty
            if @board[column.to_i][i] == "z"
              @board[column.to_i][i]= symbol
               @rowcoordinate=i
              return true
            else
              i-=1
            end
          end
       #If column_available returns false, that must mean the column is full
       #We then need to render the board and ask for a different coord and loop 
       render
       puts "That column is full, pick another one"
       return false
       end
   end


   def column_avaliable?
       if @board[@column.to_i].size <=6
           return true
       else
           return false
       end
   end

   #Used to determine if the top row of the board is completely filled
   #If so, that must mean that the players produced a tie
   def full?
    if (@board[0][0] != "z" && @board[1][0] != "z" && @board[2][0] != "z" && @board[3][0] != "z" && @board[4][0] != "z" && @board[5][0] != "z" && @board[6][0] != "z")
      return true
      else
      return false
      end
   end  


   def winning_combination?
       winning_vertical? || winning_horizontal? || winning_diagonal? 
   end


   def winning_vertical?
       verticalarray=[@board[@column.to_i][5],@board[@column.to_i][4],@board[@column.to_i][3],
       @board[@column.to_i][2],@board[@column.to_i][1],@board[@column.to_i][0]]
       four_in_a_row?(verticalarray)
   end


   def four_in_a_row?(arr)
       arr.join.to_s.include?("XXXX") || arr.join.to_s.include?("OOOO")
   end


   def winning_horizontal?
      horizontalarray=[@board[0][@rowcoordinate],@board[1][@rowcoordinate],
      @board[2][@rowcoordinate],@board[3][@rowcoordinate],@board[4][@rowcoordinate],
      @board[5][@rowcoordinate], @board[6][@rowcoordinate]]
      four_in_a_row?(horizontalarray)
   end



   def winning_diagonal?
    upleft?(@column.to_i,@rowcoordinate.to_i) || upright?(@column.to_i,@rowcoordinate.to_i)
   end 


   #Method for checking the diagonal win conditions
   def upleft? (tempcolumn, tempcordinate) 
      n=0 
      i=0
      checkarray = []

      checkpointcolumn = tempcolumn
      checkpointcordinate = tempcordinate

      #Until 'i' loop checks for objects in the array that are one down and one right
      #The loop runs four times or until it hits a border
      #If the array is valid, the object within the array gets pushed to our checker
      until i ==4
        if tempcolumn == -1 || tempcordinate == -1 || tempcolumn == 7 || tempcordinate == 6
          break
        else
        checkarray.push @board[tempcolumn][tempcordinate]
        tempcolumn += 1 
        tempcordinate += 1
        i += 1
      end
    end

    #These variables are reduced by 1 to account for the duplicate of @board[tempcolumn][tempcordinate]
    tempcolumn = checkpointcolumn-1
    tempcordinate = checkpointcordinate-1

      until n ==3
        if tempcolumn == -1 || tempcordinate == -1 || tempcolumn == 7 || tempcordinate == 6
          break
        else 
        checkarray.unshift @board[tempcolumn][tempcordinate]
        tempcolumn -= 1 
        tempcordinate -= 1
        n += 1
      end 
    end 

    #After all the possible left side diagonals are added into our checkarray
    #The checkarray is ran through our four_in_a_row checker method 
    if four_in_a_row?(checkarray)
      return true
    else 
      return false
    end 

    end 



   def upright? (tempcolumn, tempcordinate) 
      n=0 
      i=0
      checkarray = []

      checkpointcolumn = tempcolumn
      checkpointcordinate = tempcordinate


      until i ==4
        if tempcolumn == -1 || tempcordinate == -1 || tempcolumn == 7 || tempcordinate == 6
          break
        else
        checkarray.push @board[tempcolumn][tempcordinate]
        tempcolumn -= 1 
        tempcordinate += 1
        i += 1
      end
    end
    puts checkarray


    tempcolumn = checkpointcolumn-1
    tempcordinate = checkpointcordinate-1

      until n ==3
        if tempcolumn == -1 || tempcordinate == -1 || tempcolumn == 7 || tempcordinate == 6
          break
        else 
        checkarray.unshift @board[tempcolumn][tempcordinate]
        tempcolumn += 1 
        tempcordinate -= 1
        n += 1
      end 
    end 

    if four_in_a_row?(checkarray)
      return true
    else 
      return false
    end 

    end 


end