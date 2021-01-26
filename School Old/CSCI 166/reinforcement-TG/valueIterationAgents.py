# valueIterationAgents.py
# -----------------------
# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).


# valueIterationAgents.py
# -----------------------
# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).

import mdp, util

from learningAgents import ValueEstimationAgent
import collections


from itertools import cycle


class ValueIterationAgent(ValueEstimationAgent):
    """
        * Please read learningAgents.py before reading this.*
        A ValueIterationAgent takes a Markov decision process
        (see mdp.py) on initialization and runs value iteration
        for a given number of iterations using the supplied
        discount factor.
    """

    def __init__(self, mdp, discount=0.9, iterations=100):
        """
          Your value iteration agent should take an mdp on
          construction, run the indicated number of iterations
          and then act according to the resulting policy.
          Some useful mdp methods you will use:
              mdp.getStates()
              mdp.getPossibleActions(state)
              mdp.getTransitionStatesAndProbs(state, action)
              mdp.getReward(state, action, nextState)
              mdp.isTerminal(state)
        """
        self.mdp = mdp
        self.discount = discount
        self.iterations = iterations
        self.values = util.Counter()  # A Counter is a dict with default 0
        self.runValueIteration()

    "get the max of the action and qs"
    def Max(self, s):
        "get the available actions"
        actions = self.mdp.getPossibleActions(s)
        "get the q values"
        qs = (self.computeQValueFromValues(s, a) for a in actions)
        "finally return the max"
        return max(qs, default=0)

    def runValueIteration(self):
        "*** YOUR CODE HERE ***"
        self.values = util.Counter()
        states = self.mdp.getStates()
        for k in range(self.iterations):
            self.values = util.Counter({s: self.Max(s) for s in states})
        "*** YOUR CODE HERE ***"

    def getValue(self, state):
        """
          Return the value of the state (computed in __init__).
        """
        return self.values[state]

    def computeQValueFromValues(self, state, action):
        """
          Compute the Q-value of action in state from the
          value function stored in self.values.
        """
        "*** YOUR CODE HERE ***"
        "get the rewards from the given state"
        def getReward(s, a, s_):
            "this will return the reward + the y discount * the prev value"
            return self.mdp.getReward(s, a, s_) + self.discount*self.getValue(s_)

        "what other states can i get to and whats the probability of gettign to them"
        statesAndProbs = self.mdp.getTransitionStatesAndProbs(state, action)
        return sum(p * getReward(state, action, s) for s, p in statesAndProbs)
        "*** YOUR CODE HERE ***"

    def computeActionFromValues(self, state):
        """
          The policy is the best action in the given state
          according to the values currently stored in self.values.
          You may break ties any way you see fit.  Note that if
          there are no legal actions, which is the case at the
          terminal state, you should return None.
        """
        "*** YOUR CODE HERE ***"
        "get the q values possible."
        def theKey(a): return self.computeQValueFromValues(state, a)
        "then return the max given thos values"
        return max(self.mdp.getPossibleActions(state), key=theKey, default=None)
        "*** YOUR CODE HERE ***"

    def getPolicy(self, state):
        return self.computeActionFromValues(state)

    def getAction(self, state):
        "Returns the policy at the state (no exploration)."
        return self.computeActionFromValues(state)

    def getQValue(self, state, action):
        return self.computeQValueFromValues(state, action)


class AsynchronousValueIterationAgent(ValueIterationAgent):
    """
        * Please read learningAgents.py before reading this.*
        An AsynchronousValueIterationAgent takes a Markov decision process
        (see mdp.py) on initialization and runs cyclic value iteration
        for a given number of iterations using the supplied
        discount factor.
    """

    def __init__(self, mdp, discount=0.9, iterations=1000):
        """
          Your cyclic value iteration agent should take an mdp on
          construction, run the indicated number of iterations,
          and then act according to the resulting policy. Each iteration
          updates the value of only one state, which cycles through
          the states list. If the chosen state is terminal, nothing
          happens in that iteration.
          Some useful mdp methods you will use:
              mdp.getStates()
              mdp.getPossibleActions(state)
              mdp.getTransitionStatesAndProbs(state, action)
              mdp.getReward(state)
              mdp.isTerminal(state)
        """
        ValueIterationAgent.__init__(self, mdp, discount, iterations)

    def runValueIteration(self):
        "*** YOUR CODE HERE ***"
        states = cycle(self.mdp.getStates())
        for i in range(self.iterations):
            state = next(states)
            if not self.mdp.isTerminal(state):
                self.values[state] = self.Max(state)
        "*** YOUR CODE HERE ***"


class PrioritizedSweepingValueIterationAgent(AsynchronousValueIterationAgent):
    """
        * Please read learningAgents.py before reading this.*
        A PrioritizedSweepingValueIterationAgent takes a Markov decision process
        (see mdp.py) on initialization and runs prioritized sweeping value iteration
        for a given number of iterations using the supplied parameters.
    """

    def __init__(self, mdp, discount=0.9, iterations=100, theta=1e-5):
        """
          Your prioritized sweeping value iteration agent should take an mdp on
          construction, run the indicated number of iterations,
          and then act according to the resulting policy.
        """
        self.theta = theta
        ValueIterationAgent.__init__(self, mdp, discount, iterations)

    def getStatePredecessors(self):
        predecessors = util.Counter({s: [] for s in self.mdp.getStates()})
        for s in self.mdp.getStates():
            for a in self.mdp.getPossibleActions(s):
                for s_, p in self.mdp.getTransitionStatesAndProbs(s, a):
                    predecessors[s_].append(s)
        return predecessors

    def runValueIteration(self):
        "*** YOUR CODE HERE ***"
        predecessors = self.getStatePredecessors()
        queue = util.PriorityQueue()

        def isNotTerminal(s): return not self.mdp.isTerminal(s)

        for s in filter(isNotTerminal, self.mdp.getStates()):
            diff = abs(self.values[s] - self.Max(s))
            queue.push(s, -diff)

        for i in range(self.iterations):
            if queue.isEmpty():
                continue

            s = queue.pop()
            self.values[s] = self.Max(s)
            for p in predecessors[s]:
                diff = abs(self.values[p] - self.Max(p))
                if diff > self.theta:
                    queue.update(p, -diff)
        "*** YOUR CODE HERE ***"
