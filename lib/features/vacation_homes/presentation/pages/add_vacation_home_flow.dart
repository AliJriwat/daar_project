import 'package:daar_project/features/vacation_homes/presentation/pages/step0_welcome_page.dart';
import 'package:daar_project/features/vacation_homes/presentation/pages/step1_basic_info_page.dart';
import 'package:daar_project/features/vacation_homes/presentation/pages/step2_details_page.dart';
import 'package:daar_project/features/vacation_homes/presentation/pages/step3_services_page.dart';
import 'package:daar_project/features/vacation_homes/presentation/pages/step4_photo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../vacation_homes/presentation/cubit/vacation_home_cubit.dart';

class AddVacationHomeFlow extends StatefulWidget {
  const AddVacationHomeFlow({super.key});

  @override
  State<AddVacationHomeFlow> createState() => _AddVacationHomeFlowState();
}

class _AddVacationHomeFlowState extends State<AddVacationHomeFlow> {
  int _currentStep = 0;

  String _title = '';
  String _description = '';
  double _pricePerNight = 0.0;
  List<String> _photoUrls = [];
  String _address = '';
  double _latitude = 0.0;
  double _longitude = 0.0;
  int _maxGuests = 1;
  int _bedrooms = 1;
  int _beds = 1;
  int _bathrooms = 1;
  Map<String, bool> _services = {
    'pool': false,
    'wifi': false,
    'parking': false,
    'air_conditioning': false,
    'pet_friendly': false,
    'barbecue': false,
    'sea_access': false,
    'outdoor_shower': false,
    'spa': false,
    'tv': false,
    'sports_equipment': false,
    'outdoor_kitchen': false,
  };

  void _nextStep() {
    setState(() {
      if (_currentStep < 7) {
        _currentStep++;
      }
    });
  }

  void _previousStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  void _completeFlow() {
    final cubit = BlocProvider.of<VacationHomeCubit>(context);
    cubit.addHome(
      title: _title,
      description: _description,
      pricePerNight: _pricePerNight,
      photoUrls: _photoUrls,
      address: _address,
      latitude: _latitude,
      longitude: _longitude,
      maxGuests: _maxGuests,
      bedrooms: _bedrooms,
      beds: _beds,
      bathrooms: _bathrooms,
      services: _services,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getStepTitle()),
        leading: _currentStep > 0
            ? IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _previousStep,
        )
            : null,
      ),
      body: _buildCurrentStep(),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0: return 'Benvenuto';
      case 1: return 'Informazioni Base';
      case 2: return 'Dettagli Casa';
      case 3: return 'Servizi';
      case 4: return 'Foto';
      case 5: return 'Prezzo';
      case 6: return 'Riepilogo';
      case 7: return 'Conferma';
      default: return 'Aggiungi Casa';
    }
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return Step0WelcomePage(onNext: _nextStep);

      case 1:
        return Step1BasicInfoPage(
          onNext: (title, description) {
            _title = title;
            _description = description;
            _nextStep();
          },
        );


      case 2:
        return Step2DetailsPage(
          onNext: (guests, bedrooms, beds, bathrooms) {
            _maxGuests = guests;
            _bedrooms = bedrooms;
            _beds = beds;
            _bathrooms = bathrooms;
            _nextStep();
          },
          onBack: _previousStep,
        );

      case 3:
        return Step3ServicesPage(
          onNext: (services) {
            _services = services;
            _nextStep();
          },
          onBack: _previousStep,
          initialServices: _services,
        );

      case 4:
        return Step4PhotosPage(
          onNext: (photoUrls) {
            _photoUrls = photoUrls;
            _nextStep();
          },
          onBack: _previousStep,
        );
        /*
      case 5:
        return Step5PricePage(
          onNext: (price) {
            _pricePerNight = price;
            _nextStep();
          },
          onBack: _previousStep,
        );
      case 6:
        return Step6SummaryPage(
          title: _title,
          description: _description,
          pricePerNight: _pricePerNight,
          maxGuests: _maxGuests,
          bedrooms: _bedrooms,
          beds: _beds,
          bathrooms: _bathrooms,
          photoUrls: _photoUrls,
          services: _services,
          onComplete: _completeFlow,
          onBack: _previousStep,
        );
      case 7:
        return Step7ConfirmationPage(onComplete: () {
          Navigator.pop(context);
        });

         */
      default:
        return const Center(child: Text('Errore'));
    }
  }
}
