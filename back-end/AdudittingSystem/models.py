from django.db import models

# Create your models here.
import cv2
import json
from nltk.stem import WordNetLemmatizer


class Trie:
    def __init__(self):
        self.root = {}
        self.word_end = -1

    def insert(self, word):
        curNode = self.root
        for c in word:
            if not c in curNode:
                curNode[c] = {}
            curNode = curNode[c]

        curNode[self.word_end] = True

    def search(self, word):
        curNode = self.root
        for c in word:
            if not c in curNode:
                return False
            curNode = curNode[c]

        # Doesn't end here
        if self.word_end not in curNode:
            return False

        return True


def SENSITIVE_WORD_DETECTION(sentence):
    sentence = sentence.lower()
    sentence = sentence.split(' ')
    wnl = WordNetLemmatizer()
    new_sentence = [wnl.lemmatize(x) for x in sentence]
    with open("static/sensitive_words.json", 'r') as f:
        words = json.load(f)

    Tie = Trie()
    for x in words:
        Tie.insert(x)

    dict = {}
    for word in new_sentence:
        if Tie.search(word):
            if word in dict:
                dict[word] += 1
            else:
                dict[word] = 1
    return dict
