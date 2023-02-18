import 'package:flutter/material.dart';


class AddStockForm extends StatefulWidget{
  @override
  _AddStockFormState createState() => _AddStockFormState();

}

class _AddStockFormState extends State<AddStockForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title: Text('Add Stock'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _itemNameController,
                decoration: InputDecoration(
                  hintText: 'Enter the item name',
                  labelText: 'Item Name',
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Please enter the item name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                  keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter the quantity',
                  labelText: 'Quantity',
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Please enter the quantity';
                  }
                  if(int.typeParse(value) == null){
                    return 'Please enter a valid quantity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter the price',
                    labelText: 'Price',
                  ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Please enter a valid price';
                  }
                  if(double.tryParse(value) == null){
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              Center(
                child: RaisedButton(
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      String itemName = _itemNammeController.text;
                      int quantity = int.parse(_quantityController.text);
                      double price = double.parse(_priceController.text);
                    }
                  },
                  child: Text('Add Stock'),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

}