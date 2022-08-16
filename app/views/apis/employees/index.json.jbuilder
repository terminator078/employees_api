json.data do
  json.employees_data do
  json.array! @employees do |employee|
    json.partial! 'apis/employees/employee', employee: employee
    json.tasks do
    json.partial! 'apis/employees/tasks', tasks: @tasks[employee.id]
    end
  end
  end
end