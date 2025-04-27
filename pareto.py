
import np as numpy
class Pareto:
    def __init__(self, travelers, lambda_factor):
        self.travelers = travelers 
        self.lambda_factor = lambda_factor


    def individual_statisfaction(self, traveler):
        cost = traveler['Cost']
        time = traveler['Time']

        min_cost = traveler['Min Cost']
        max_cost = traveler['Max Cost']

        min_time = traveler['Min Time']
        max_time = traveler['Max Time']

        cost_deviation = (max(0, cost - max_cost) + max(0, min_cost - cost)) / (max_cost - min_cost)
        time_deviation = (max(0, time - max_time) + max(0, min_time - time)) / (max_time - min_time)
    
        return 1 - (cost_deviation + time_deviation)

    #need to calculate shared segments
    def overlap_score(self, paths):
        shared_segments = 1
        total_segments = 0
        for _ in len(range(paths)):
            total_segments += 1
        return shared_segments / total_segments



    def group_cost(self):
      return sum(t['Cost'] for t in self.travelers)

    
    def group_time(self):
        return sum(t['Time'] for t in self.travelers)

    def normalized_cost(self, traveler):
        min_cost = traveler['Min Cost']
        max_cost = traveler['Max Cost']
        return (traveler['Cost'] - min_cost) / (max_cost - min_cost)

    def normalized_time(self, traveler):
        min_time = traveler['Min Time']
        max_time = traveler['Max Time']
        return (traveler['Time'] - min_time) / (max_time - min_time)
    
    def normalized_cost_bias(self, traveler):
        return self.normalized_cost(traveler) / len(self.travelers)

    def normalized_time_bias(self, traveler):
        return self.normalized_time(traveler) / len(self.travelers)


    
    def combined_total_score(self, travelers, paths):
        total_individual_statisfaction = sum(self.individual_statisfaction(t) for t in travelers)
        return (self.lambda_factor * total_individual_statisfaction) + (1 - self.lambda_factor) * (self.overlap_score(paths))


    def pareto_optimal(self, path_scores):
        pareto_front = []
        for p1 in path_scores:
            dominated = False
            for p2 in path_scores:
                if ((p2[1] >= p1[1] and p2[2] <= p1[2] and p2[3] <= p1[3]) and
                    (p2[1] > p1[1] or p2[2] < p1[2] or p2[3] < p1[3])):  
                    dominated = True
                    break
            if not dominated:
                pareto_front.append(p1)
        return pareto_front

    
    def optimize(self, paths):
        path_scores = [(path, self.combined_total_score(paths)) for path in paths]
        return self.pareto_optimal(path_scores)

    def aggregate_metrics(self, traveler, paths):
        overlap = self.overlap_score(paths) 
        cost_score = self.normalized_cost_bias(traveler) 
        time_score = self.normalized_time_bias(traveler)

        return overlap, cost_score, time_score
    
    def pareto_filtering(self, path1, path2):
        if self.overlap_score(path1) >= self.overlap_score(path2) or self.normalized_cost_bias <= self.normalized_cost_bias:
            return path1

    

    
    


