require 'board'

describe Board do 

	let (:b){Board.new}

  describe '#initialize' do
  	it 'raises error with no arugments' do 
  	  expect(b).to raise_error(ArgumentError)
  	end
  	it 'counter is equal to zero' do
  	  expect(b.counter).to eq(0)
  	end
  end

  describe '#winning_vertical?' do 
     it 'To see if the winning condition for verical returns true' do
         b.board[0][0]="X"
         b.board[0][1]="X"
         b.board[0][2]="X"
         b.board[0][3]="X"
         b.board[0][4]="X"
         b.board[0][5]="X"
         expect(b.winning_vertical?).to eq(true)
     end

     it 'To see if winning condition for vertical returns false' do
     	b.board[0][0]="X"
         b.board[0][1]="z"
         b.board[0][2]="X"
         b.board[0][3]="z"
         b.board[0][4]="X"
         b.board[0][5]="z"
         expect(b.winning_vertical?).to eq(false)
     end
   end


   describe '#winning_horizontal' do
   	it 'to see if winning condition for horizontal returns true' do
   		b.board[0][0]="X"
   		b.board[1][0]="X"
         b.board[2][0]="X"
         b.board[3][0]="X"
         b.board[4][0]="X"
         b.board[5][0]="X"
         b.board[6][0]="X"
         expect(b.winning_horizontal?).to eq(true)
     end
     	it 'to see if winning condition for horizontal returns false' do
   		b.board[0][0]="z"
   		b.board[1][0]="X"
         b.board[2][0]="X"
         b.board[3][0]="z"
         b.board[4][0]="z"
         b.board[5][0]="X"
         b.board[6][0]="X"
         expect(b.winning_horizontal?).to eq(false)
     end
  end

   describe '#winning_diagonal' do 
   		it 'to see if winning condition for winning_diagonal returns true' do
   		b.board[0][0]="X"
   		b.board[1][1]="X"
         b.board[2][2]="X"
         b.board[3][3]="X"
         b.board[4][4]="X"
         b.board[5][5]="X"
         b.board[6][6]="X"
         expect(b.winning_diagonal?).to eq(true)
     end
     	it 'to see if winning condition for winning_diagonal returns false' do
   		b.board[0][0]="z"
   		b.board[1][1]="X"
         b.board[2][2]="X"
         b.board[3][3]="z"
         b.board[4][4]="z"
         b.board[5][5]="X"
         b.board[6][6]="X"
         expect(b.winning_diagonal?).to eq(false)
     end
  end






end