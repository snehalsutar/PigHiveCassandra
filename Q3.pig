movies = LOAD '/svs130130/movies.dat' USING PigStorage(':') AS (movieID:int, title:chararray, genre:chararray);
ratings = LOAD '/svs130130/ratings.dat' USING PigStorage(':') AS (userID:int, movieID:int, rating:float, timeStamp:int);


moviesRatingsCogroup = COGROUP ratings BY movieID, movies by movieID;
finalCogroup =  FOREACH moviesRatingsCogroup GENERATE FLATTEN(ratings), FLATTEN(movies);
C = LIMIT finalCogroup 6;
DUMP C;
store C into ' /home/004/s/sv/svs130130/output_Q3';
