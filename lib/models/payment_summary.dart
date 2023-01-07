class PaymentSummary {
  double dueAmount=0.0;
  double paidAmount=0.0;
  DateTime? dueDate;
  List<Payment> payments=[];

  PaymentSummary({required this.dueAmount,required this.dueDate});

  PaymentSummary.fromJson(Map<String, dynamic> json) {
    if(json['due_amount']!=null){
      dueAmount = double.parse(json['due_amount'].toString())  * 1.0;
    }
    if(json['due_date']!=null){
      dueDate = DateTime.parse(json['due_date']);
    }
    if(json['paid_amount']!=null){
      paidAmount = double.parse(json['paid_amount'].toString())  * 1.0;
    }
      
    if (json['transactions'] != null) {
      payments = <Payment>[];
      json['transactions'].forEach((v) {
        payments.add(Payment.fromJson(v));
      });
    }
  }

  
}

class Payment {
  double paidAmount=0.0;
  DateTime? paidDate;
  int paymentMethod=1;
  Payment({required this.paidAmount,required this.paidDate});

  Payment.fromJson(Map<String, dynamic> json) {
     if(json['paid_amount']!=null){
      paidAmount = double.parse(json['paid_amount'].toString())  * 1.0;
    }else{
      paidAmount=0.0;
    }
     if(json['paid_date']!=null){
      paidDate = DateTime.parse(json['paid_date'].toString());
    }
     if(json['payment_method']!=null){
      paymentMethod = int.parse(json['payment_method'].toString());
    }
  }

  
}