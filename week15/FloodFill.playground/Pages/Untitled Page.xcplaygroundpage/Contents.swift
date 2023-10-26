import Foundation

// MARK: - Simple Queue
struct Queue<T> {
  var elements: [T] = []
  var index = 0 // front pointer

  var isEmpty: Bool {
    elements.count < index + 1
  }

  mutating func enqueue(_ data: T) {
    elements.append(data)
  }

  mutating func dequeue() -> T {
    let value = elements[index]
    index += 1
    return value
  }
}

func boardPrint(board: [[Int]]) {
  for y in 0..<board.count {
    for x in 0..<board[0].count {
      print(board[y][x], terminator: " ")
    }
    print("")
  }
}

var board: [[Int]] = [
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
  [0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0],
  [0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0],
  [0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0],
  [0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0],
  [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
]
let w = board[0].count
let h = board.count

print("----------------")
print("inital board:")
boardPrint(board: board)
//(y,x)
// Start Point = (4, 5)
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

var queue = Queue<(Int, Int)>()
var vis: [[Bool]] = .init(
  repeating: .init(repeating: false, count: w), count: h
)

queue.enqueue((4, 5))
vis[4][5] = true

//bfs
while !queue.isEmpty{
    let curr = queue.dequeue()
    let y = curr.0
    let x = curr.1
    board[y][x] = 1
    vis[y][x] = true
    
    for i in 0..<4{
        let ny = y + dy[i]
        let nx = x + dx[i]
        //visited check
        if vis[ny][nx] { continue }
        //value check
        if board[ny][nx] == 1 { continue }
        //bound check logic
        if ny < 0 || ny >= h || nx < 0 || nx > w {continue}
        if board[ny][nx] == 0 && vis[ny][nx] != true{
            queue.enqueue((ny,nx))
        }
    }
    
}

print("----------------")
print("after board:")
boardPrint(board: board)

print(queue)
