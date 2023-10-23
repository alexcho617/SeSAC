//: [Previous](@previous)

import Foundation

class Node<String> {
    var value: String
    var next: Node?
    
    init(value: String, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

class LinkedList<String> {
    var head: Node<String>?
    
    func append(value: String) {
        let newNode = Node(value: value)
        if head == nil {
            head = newNode
        } else {
            var current = head
            //끝까지 감
            while current?.next != nil {
                current = current?.next
            }
            //맨 마지막에 추가함
            current?.next = newNode
        }
    }
}

extension LinkedList {
    func printList() {
        var current = head
        while current != nil {
            print(current!.value, terminator: " -> ")
            current = current?.next
        }
        print("nil")
    }
}

let linkedList = LinkedList<String>()
linkedList.append(value: "코코종")
linkedList.append(value: "브랜")
linkedList.append(value: "잭")

linkedList.printList()


extension LinkedList {
    func insert(value: String, at index: Int) {
        let newNode = Node(value: value)
        if index == 0 {
            newNode.next = head
            head = newNode
        } else {
            var currentNode = head
            for _ in 0..<index - 1 {
                if currentNode == nil {
                    break
                }
                currentNode = currentNode?.next
            }
            
            if currentNode != nil {
                newNode.next = currentNode?.next
                currentNode?.next = newNode
            }
        }
    }
    
    func delete(at index: Int) {
           if index == 0 {
               head = head?.next
           } else {
               var currentNode = head
               for _ in 0..<index - 1 {
                   if currentNode == nil {
                       break
                   }
                   currentNode = currentNode?.next
               }
               if currentNode != nil && currentNode?.next != nil {
                   currentNode?.next = currentNode?.next?.next
               }
           }
       }
}

linkedList.insert(value: "일찐 휴", at: 1)
linkedList.printList()

linkedList.delete(at: 2)
linkedList.printList()
