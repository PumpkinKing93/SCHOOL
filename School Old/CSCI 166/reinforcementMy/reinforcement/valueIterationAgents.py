import mdp
import util

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

    def maxQ(self, s):
        actions = self.mdp.getPossibleActions(s)
        qs = (self.computeQValueFromValues(s, a) for a in actions)
        return max(qs, default=0)

    def runValueIteration(self):
        self.values = util.Counter()
        states = self.mdp.getStates()
        for k in range(self.iterations):
            self.values = util.Counter({s: self.maxQ(s) for s in states})

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

        def rewardIf(s, a, s_):
            return self.mdp.getReward(s, a, s_) + self.discount*self.getValue(s_)

        statesAndProbs = self.mdp.getTransitionStatesAndProbs(state, action)
        return sum(p * rewardIf(state, action, s) for s, p in statesAndProbs)

    def computeActionFromValues(self, state):
        """
          The policy is the best action in the given state
          according to the values currently stored in self.values.
          You may break ties any way you see fit.  Note that if
          there are no legal actions, which is the case at the
          terminal state, you should return None.
        """
        def key_fn(a): return self.computeQValueFromValues(state, a)
        return max(self.mdp.getPossibleActions(state), key=key_fn, default=None)

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
        states = cycle(self.mdp.getStates())
        for i in range(self.iterations):
            state = next(states)
            if not self.mdp.isTerminal(state):
                self.values[state] = self.maxQ(state)


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
        predecessors = self.getStatePredecessors()
        queue = util.PriorityQueue()

        def isNotTerminal(s): return not self.mdp.isTerminal(s)

        for s in filter(isNotTerminal, self.mdp.getStates()):
            diff = abs(self.values[s] - self.maxQ(s))
            queue.push(s, -diff)

        for i in range(self.iterations):
            if queue.isEmpty():
                continue

            s = queue.pop()
            self.values[s] = self.maxQ(s)
            for p in predecessors[s]:
                diff = abs(self.values[p] - self.maxQ(p))
                if diff > self.theta:
                    queue.update(p, -diff)