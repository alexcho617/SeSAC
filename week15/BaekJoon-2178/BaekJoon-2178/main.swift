//
//  main.swift
//  BaekJoon-2178
//
//  Created by Alex Cho on 2023/10/26.
//

import Foundation
//https://www.acmicpc.net/problem/2178
//O(n*m) 모든 좌표를 한번씩만 돈다
//visited에 스텝을 저장하면 됨
//마지막엔 끝 지점의 visited 반환
let input = readLine()!.split(separator: " ").map { Int($0)! }
let n = input[0]
let m = input[1]
var board: [[Int]] = []
var visited: [[Int]] = .init(repeating: .init(repeating: -1, count: m), count: n)
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

for _ in 1...n{
    let input = readLine()!.map{Int(String($0))!}
    board.append(input)
}

//var queue = Queue<(Int,Int)>()
var queue: [(Int,Int)] = []
queue.append((0,0))
visited[0][0] = 1
var index = 0 //포인터 개념

while queue.count >= index + 1{
    let curr = queue[index]
    index += 1
    
    for dir in 0..<4 {
        let ny = curr.0 + dy[dir]
        let nx = curr.1 + dx[dir]
        
        if ny < 0 || ny >= n || nx < 0 || nx >= m { continue } //bound
        if visited[ny][nx] != -1 { continue } //visited
        if board[ny][nx] == 0 { continue } //value
        
        visited[ny][nx] = visited[curr.0][curr.1] + 1
        queue.append((ny,nx))
    }
}


print(visited[n-1][m-1])

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
