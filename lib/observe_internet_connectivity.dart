library observe_internet_connectivity;

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

part 'constants.dart';

part 'internet_connectivity.dart';

part 'internet_observing_strategies/default_observing_strategy.dart';

part 'internet_observing_strategies/dispose_after_duration.dart';

part 'internet_observing_strategies/dispose_on_first_connected.dart';

part 'internet_observing_strategies/dispose_on_first_disconnected.dart';

part 'internet_observing_strategies/internet_observing_strategy.dart';

part 'internet_observing_strategies/socket_observing_strategy.dart';

part 'models/internet_address.dart';

part 'widgets/internet_connectivity_builder.dart';

part 'widgets/internet_connectivity_listener.dart';
