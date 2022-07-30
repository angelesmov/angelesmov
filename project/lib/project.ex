#Final Project
# Transformar datos de un archivo CSV (sin morir en el intento)
#
#Ángeles Hernández
#Yair Camacho
#2022-07-28

defmodule Project do
  @moduledoc """
  Provides a function `main/2` that takes csv file with the sales per month of
  three branch regions of a store and retuns a new file with the total sales per
  region
  """

  @doc """
  Takes a csv file and calculates the total sales for each region

  ## Parameters
    - in_filename: String with the name of the file with the data to calculate
    - out_filename: String with the name of the file with the computed data

  ## Examples
    iex> Project.main("Sales-data-CompuStore.csv", "Total_per_region.csv")
    :ok

  """
  def main(in_filename, out_filename) do
    # Read the file
    data = read_file(in_filename)
    # Remove header
    [_header | raw_data] = data
    # Send table to process, row by row
    process_row(raw_data, 0, 0, 0)
    # Remorfat the table
    |> format_table()
    # Write the new file
    |> write_csv(out_filename)
  end

  # This function is in charge of reading the file and transforms into a table
  defp read_file(in_filename) do
    in_filename
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, ","))
  end

  # This function goes one by one for each of the rows in the table
  # When the row is empty (base control)
  defp process_row([], total_1, total_2, total_3),
  # The float values are rounded by two decimals
    do: [Float.ceil(total_1, 2), Float.ceil(total_2, 2), Float.ceil(total_3, 2)]

  # When the row is not empty
  defp process_row([row | tail], total_1, total_2, total_3) do
    # We rescue the data that we are going to need
    [_store, region_str, _item, unitprice_str, quantity_str, _month] = row

    # Casting the data from string to integer and float
    region_int = String.to_integer(region_str)
    quantity_int = String.to_integer(quantity_str)
    # Removing trailing and leading spaces
    unitprice_temp = String.trim(unitprice_str)
    unitprice_flt = String.to_float(unitprice_temp)

    # Calculating and saving the total sales for the current row
    [subtotal_1, subtotal_2, subtotal_3] =
      compute_data([region_int, unitprice_flt, quantity_int], total_1, total_2, total_3)

    # This is the recursive call
    process_row(tail, subtotal_1, subtotal_2, subtotal_3)
  end

  # This function makes the product between unit price and quantity of items sold
  # adds it to the total count of the respecting region
  defp compute_data([region, unitprice, quantity], total_1, total_2, total_3) do
    case region do
      1 -> [(total_1 + (unitprice * quantity)), total_2, total_3]
      2 -> [total_1, (total_2 + (unitprice * quantity)), total_3]
      3 -> [total_1, total_2, (total_3 + (unitprice * quantity))]
    end
  end

  # This function binds the total of sales whith their region
  defp format_table([total_1, total_2, total_3]) do
    [
      ["1",Float.to_string(total_1)],
      ["2",Float.to_string(total_2)],
      ["3",Float.to_string(total_3)]
    ]
  end

  # This function is charge of write the new data
  # into a file with the specified name
  defp write_csv(data, out_filename) do
    cvs_data =
      # Add new header
      ["Region", "Ventas Totales"]
      # Merge the header wit the new table
      |> Kernel.then(&[&1 | data])
      |> Enum.map(&Enum.join(&1, ","))
      |> Enum.join("\n")
      # Write the data into a new file
      out_filename
      |> Path.expand(__DIR__)
      |> File.write(cvs_data)
  end
end
