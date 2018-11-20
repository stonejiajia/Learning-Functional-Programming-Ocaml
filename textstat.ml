

type stats = int * int * int * int;;

let stats_from_channel _= (0, 0, 0, 0);;

let stats_from_file filename = 
  let channel = open_in filename in
    let result = stats_from_channel channel in
      close_in channel;
      result
