#!/usr/bin/env python3
"""
Hadoop MapReduce - WordCount Example (Reducer)
This is the reducer script for the classic WordCount example using Hadoop Streaming
"""

import sys
from collections import defaultdict

def reducer():
    """
    Read mapper output from stdin and sum the counts for each word
    """
    word_counts = defaultdict(int)
    
    for line in sys.stdin:
        # Remove leading and trailing whitespace
        line = line.strip()
        
        # Parse the input we got from mapper
        try:
            word, count = line.split('\t')
            count = int(count)
            
            # Aggregate counts
            word_counts[word] += count
        except ValueError:
            # Ignore malformed lines
            continue
    
    # Emit the results
    for word, count in sorted(word_counts.items()):
        print(f"{word}\t{count}")

if __name__ == "__main__":
    reducer()
