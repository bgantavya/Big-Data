#!/usr/bin/env python3
"""
Hadoop MapReduce - WordCount Example (Mapper)
This is the mapper script for the classic WordCount example using Hadoop Streaming
"""

import sys

def mapper():
    """
    Read input from stdin and emit (word, 1) pairs
    """
    for line in sys.stdin:
        # Remove leading and trailing whitespace
        line = line.strip()
        
        # Split the line into words
        words = line.split()
        
        # Emit each word with count of 1
        for word in words:
            # Convert to lowercase for case-insensitive counting
            word = word.lower()
            
            # Remove punctuation (simple approach)
            word = ''.join(char for char in word if char.isalnum())
            
            if word:  # Only emit non-empty words
                # Output: word \t 1
                print(f"{word}\t1")

if __name__ == "__main__":
    mapper()
