#!/usr/bin/env ruby

def main
  begin
  puts "Starting exercice"

  exit_status = create_network

  exit(exit_status) if exit_status&.positive?

  rescue SystemExit => e
    puts "Program finished with non zero code : #{e.status}"
  end

end

# Procedure to setup a docker container
def create_network
  create = prompt "Do you want to create a new docker network ? #{accept_or_refuse} "
  return 2 unless create == "y"

  cont_name = container_name(3)

  puts cont_name
end

# Recursive prompt to ensure container name is greater or equal to the min length
def container_name(min_len = 2, message="Please enter the container name : ")
  name = prompt(message)

  return name unless name.size < min_len

  container_name(min_len, message)
end

# Returns user input from STDIN
def prompt(*args)
  print(*args)
  STDIN.gets.chomp
end

def accept_or_refuse
  "[y/n]"
end

# DockerNetwork describe a docker network class usefull for our needs to finish the exercice
class DockerNetwork
  attr_reader :container_name

  def new(container_name)
    @container_name = container_name
  end
end


main
