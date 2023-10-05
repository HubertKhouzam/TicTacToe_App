
import SwiftUI


struct HomePageView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Tic Tac Toe Game")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.black)
            NavigationLink(
                destination: PlayerVsPlayer(),
                label: {
                    Text("Player Vs Player")
                        .padding()
                        .bold()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(100)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                })
            NavigationLink(
                destination: PlayerVsAI(),
                label: {
                    Text("Player Vs AI")
                        .padding()
                        .bold()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(100)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                })
            
        }
        .padding()
    }
}

struct PlayerVsPlayer: View
{
    @StateObject var gameState = GameState()
    
    var body: some View
    {
        
        let borderSize = CGFloat(5)
        
        Text(gameState.turnText())
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .bold()
            .padding()
        Spacer()
        
        Text(String(format: "Crosses: %d", gameState.crossScore))
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .bold()
            .padding()
        Spacer()
        
        VStack(spacing: borderSize)
        {
            ForEach(0...2, id: \.self)
            {
                row in
                HStack(spacing: borderSize)
                {
                    ForEach(0...2, id: \.self)
                    {
                        column in
                        
                        let cell = gameState.board[row][column]
                        
                        Text(cell.displayTile())
                            .font(.system(size: 60))
                            .foregroundColor(cell.tileColor())
                            .bold()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .background(Color.white)
                            .onTapGesture {
                                gameState.placeTile(row, column)
                            }
                    }
                }
            }
        }
        .background(Color.black)
        .padding()
        .alert(isPresented: $gameState.showAlert)
        {
            Alert(
                title: Text(gameState.alertMessage),
                dismissButton:  .default(Text("Okay"))
                {
                    gameState.resetBoard()
                }
            )
        }
        Text(String(format: "Nougths: %d", gameState.noughtScore))
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .bold()
            .padding()
        Spacer()
    }
}

struct PlayerVsAI: View
{
    @StateObject var gameState = GameState()
    var body: some View
    {
        let borderSize = CGFloat(5)
        
        Text(gameState.turnText())
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .bold()
            .padding()
        Spacer()
        
        Text(String(format: "Player: %d", gameState.crossScore))
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .bold()
            .padding()
        Spacer()
        
        VStack(spacing: borderSize)
        {
            ForEach(0...2, id: \.self)
            {
                row in
                HStack(spacing: borderSize)
                {
                    ForEach(0...2, id: \.self)
                    {
                        column in
                        
                        let cell = gameState.board[row][column]
                        
                        Text(cell.displayTile())
                            .font(.system(size: 60))
                            .foregroundColor(cell.tileColor())
                            .bold()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .background(Color.white)
                            .onTapGesture {
                                gameState.placeTile_AI(row, column)
                                
                            }
                    }
                }
            }
        }
        .background(Color.black)
        .padding()
        .alert(isPresented: $gameState.showAlert)
        {
            Alert(
                title: Text(gameState.alertMessage),
                dismissButton:  .default(Text("Okay"))
                {
                    gameState.resetBoard()
                }
            )
        }
        Text(String(format: "AI: %d", gameState.noughtScore))
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .bold()
            .padding()
        Spacer()
    }
}

#Preview {
    HomePageView()
}


